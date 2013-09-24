#!/bin/sh
#
###############################################################################
#
# A script to ease playing Digitally Imported and SKY.fm Internet radio
#
# Author: Lasse Collin <lasse.collin@tukaani.org>
#
# This file has been put into the public domain.
# You can do whatever you want with this file.
#
# Last updated: 2013-03-17 17:00+0200
#
# Thanks:
#   - Antti Harri
#   - Denis Krienbühl
#
###############################################################################

# Program name to display in messages. This looks nicer than $0 which
# contains the full path.
PROG=${0##*/}

# Don't let environment variables mess up with the config.
unset BITRATE PREMIUM PLAYER MENU CHANNEL MY_CHANNELS MY_URLS

# Read the config file if it exists.
CONF=~/.difmplayrc
[ -f "$CONF" ] && . "$CONF"

# Optional channel list configuration file:
CHANNELS_CONF=~/.difmplay_channels

# Message to display with -h.
HELP="Usage: $PROG [OPTION]... [CHANNEL]
Play a stream from Digitally Imported <http://www.di.fm/>
or SKY.fm <http://www.sky.fm/> Internet radio.
For high-quality streams, premium subscription is required.

  -b BITRATE        Set the bitrate as kbit/s for the premium subscription.
                    256 is MP3. 128, 64, and 40 are AAC. The default is 256.
                    If the premium ID is not set, this option is ignored and
                    the free stream is played.
  -i PREMIUM        Set the premium ID (a hexadecimal string) needed
                    to construct URLs for premium streams. You can
                    find this string by looking at the URLs of the
                    channels when logged in DI.fm or SKY.fm website.
  -p PLAYER         Set the command to use as the audio player. It has to
                    accept an URL to the playlist (.pls) as the last
                    argument. Wordsplitting is applied to PLAYER, which makes
                    it possible to pass additional command line options to
                    the player program. The default is \`mplayer -playlist'.
  -m                Display a menu using \`dialog' to select the channel
                    and bitrate. The default selections can be specified in
                    the config file or on the command line.
  -n                Don't display a menu even if config file has MENU=yes
                    or the -m option was already used.
  -l                Display the list of available channels. (May be outdated.)
  -u                Download a new channel list to ~/.difmplay_channels.
                    This may not work if the web site formatting has changed.
  -h                Display this help message.

CHANNEL may be an abbreviated name of the channel. The abbreviation has to be
unique except when setting the default selection for the menu.

Default settings can be set in ~/.difmplayrc. It is read as an \`sh' script.
Supported configuration variable names are BITRATE, PREMIUM, PLAYER, MENU
(valid values being \`yes' and \`no'), CHANNEL, MY_CHANNELS, and MY_URLS.

Custom channels can be defined in ~/.difmplayrc: MY_CHANNELS should contain
a white space separated list of channel names that don't conflict with
predefined channel names. MY_URLS should contain a list of playlist URLs.

Report bugs to <lasse.collin@tukaani.org> (in English or Finnish).
difmplay home page: <http://tukaani.org/difmplay/>"

# List of supported channels (to show the channel list and to quickly catch
# typos). You can get updated lists with difmplay -u.
#
# The first and last character in these strings must be a space for
# validation with `case'.
CHANNELS_DI=" umfradio umf_stage1 mainstage bigroomhouse eclectronica \
russianclubhits trance vocaltrance lounge chillout vocalchillout house \
progressive minimal harddance eurodance electro techhouse psychill goapsy \
progressivepsy hardcore djmixes ambient drumandbass classictechno \
epictrance ukgarage breaks cosmicdowntempo techno soulfulhouse deephouse \
deeptech tribalhouse funkyhouse deepnudisco spacemusic hardstyle \
chilloutdreams liquiddnb darkdnb classiceurodance handsup club \
classictrance classicvocaltrance clubdubstep dubstep liquiddubstep \
glitchhop discohouse classiceurodisco futuresynthpop latinhouse \
oldschoolacid chiptunes "
CHANNELS_SKY=" hit60s classicmotown russianpop russiandance israelihits \
smoothjazz lovemusic tophits the80s smoothlounge newage solopiano \
relaxation classical mellowjazz cafedeparis hit90s 80srock softrock poprock \
modernrock hardrock metal modernblues smoothjazz247 compactdiscoveries \
vocalnewage nature soundtracks relaxingexcursions hit70s ska oldies \
dreamscapes classicalpianotrios guitar country rootsreggae bossanova \
vocalsmoothjazz uptemposmoothjazz datempolounge pianojazz salsa world \
romantica classicrock altrock indierock dancehits urbanjamz poppunk \
classicrap bebop jazzclassics americansongbook beatles jpop clubbollywood \
christian "

# Load the channel list file if it exists. It isn't validated so
# the user hopefully doesn't put nonsense into it.
[ -f "$CHANNELS_CONF" ] && . "$CHANNELS_CONF"

# MY_CHANNELS might have any amount of white space. Convert it to the same
# format as above.
CHANNELS_CUSTOM=$(echo "x$MY_CHANNELS" | tr '[:space:]' ' ' \
		| sed 's/^x//;s/ \{1,\}/ /g;s/^ */ /;s/ *$/ /')

# Updating cannot be set from the config file.
UPDATE=no

# Parse the command line arguments.
while getopts 'b:hi:lmnp:u' ARG "$@"; do
	case $ARG in
		b)
			BITRATE=$OPTARG
			;;
		h)
			echo "$HELP"
			exit 0
			;;
		i)
			PREMIUM=$OPTARG
			;;
		l)
			# Behave differently depending on if stdout is
			# a terminal or not.
			if tty -s 0>&1; then
				# column is not in POSIX but many systems
				# have it.
				echo "$CHANNELS_DI$CHANNELS_SKY$CHANNELS_CUSTOM" \
						| tr ' ' '\n' | column
			else
				# Not writing to a terminal, so make it easier
				# to pipe the channel list to other programs.
				echo "$CHANNELS_DI$CHANNELS_SKY$CHANNELS_CUSTOM" \
						| tr ' ' '\n' | sed '/^$/d'
			fi
			exit 0
			;;
		m)
			MENU=yes
			;;
		n)
			MENU=no
			;;
		p)
			PLAYER=$OPTARG
			;;
		u)
			UPDATE=yes
			break
			;;
		*)
			echo "Try \`$PROG -h' for help." >&2
			exit 1
			;;
	esac
done

# If requested, download an updated channels list and store it
# into $CHANNELS_CONF.
if [ "$UPDATE" = "yes" ]; then
	# Stop on errors.
	set -e

	echo "$PROG: Downloading new channel lists..."

	UPDATE=$(
		echo "# Autogenerated with \`$PROG -u' on $(date +%Y-%m-%d)."
		echo "# Tiny changes can break $PROG so" \
			"do not edit this file manually."
		echo

		# Channels from www.di.fm.
		# Use a nice format which can be directly copypasted into
		# this script when making a new release.
		{
			echo 'CHANNELS_DI="'
			curl -s http://www.di.fm/ | sed -n \
				's|^.*/public3/\([a-z0-9_]\{1,\}\)\.pls">96.*$|\1|p'
		} | tr '\n' ' ' | fold -sw 76 | sed '$!s/$/\\/; $s/$/"/'
		echo
		echo

		# Channels from www.sky.fm.
		{
			echo 'CHANNELS_SKY="'
			curl -s http://www.sky.fm/ | sed -n \
				's|^.*href="/play/\([a-z0-9_]\{1,\}\)".*Listen Now.*$|\1|p'
		} | tr '\n' ' ' | fold -sw 76 | sed '$!s/$/\\/; $s/$/"/'
		echo
	)

	# All hopefully went fine so far. Write a new channel list file.
	echo "$UPDATE" > "$CHANNELS_CONF"
	echo "$PROG: Updated channel lists saved to $CHANNELS_CONF."
	exit 0
fi

# Set the defaults for settings not specified in the config file or
# on the command line.
MENU=${MENU:-no}
PLAYER=${PLAYER:-'mplayer -playlist'}

if [ -z "$PREMIUM" ]; then
	BITRATE=free
elif [ -z "$BITRATE" ]; then
	BITRATE=256
fi

# Non-option arguments currently include only the channel name.
shift $(expr $OPTIND - 1)
case $# in
	0)
		# Using the default channel from the config file.
		if [ -z "$CHANNEL" -a "$MENU" = "no" ]; then
			echo "$PROG: No channel was specified in the config" \
					"file or on the command line."
			exit 1
		fi
		;;
	1)
		CHANNEL=$1
		;;
	*)
		echo "$PROG: Too many command line arguments." >&2
		echo "Try \`$PROG -h' for help." >&2
		exit 1
		;;
esac

# Validate the bitrate.
case $BITRATE in
	40|64|128|256|free) ;;
	*)
		echo "$PROG: Supported bitrates are 256, 128, 64, and 40." >&2
		exit 1
		;;
esac

# Roughly validate the channel name so that it doesn't cause us problems.
case $CHANNEL in
	*" "*|*"'"*)
		echo "$PROG: Channel name must not contain spaces or" \
				"quote characters." >&2
		echo "Use \`$PROG -l' to view the list of channels." >&2
		exit 1
		;;
esac

# See if the given channel name matches a known channel name. The channel
# name can be abbreviated, and it has to be unique unless we are going to
# display a menu.
MATCH=
for ARG in $CHANNELS_DI$CHANNELS_SKY$CHANNELS_CUSTOM; do
	case $ARG in
		"$CHANNEL")
			# Exact channel name was found.
			MATCH=$ARG
			break
			;;
		"$CHANNEL"*)
			# Abbreviated channel name was found.
			if [ -n "$MATCH" ]; then
				# If we are using a menu, don't complain
				# about ambiguous channel names, but keep
				# looking for exact match.
				[ "$MENU" = "yes" ] && continue
				echo "$PROG: \`$CHANNEL' is ambiguous." >&2
				echo "Use \`$PROG -l' to view the list" \
						"of channels." >&2
				exit 1
			fi
			MATCH=$ARG
			;;
	esac
done

# If we are going to display a menu, it's OK if we found no channel name.
if [ -z "$MATCH" -a "$MENU" = "no" ]; then
	echo "$PROG: Unknown channel name: $CHANNEL" >&2
	echo "Use \`$PROG -l' to view the list of channels." >&2
	exit 1
fi
CHANNEL=$MATCH

# Display the menu if requested.
if [ "$MENU" = "yes" ]; then
	# Ask the channel.
	MENUCMD="dialog --backtitle $PROG --default-item '$CHANNEL'"
	MENUCMD="$MENUCMD --menu 'Select the channel:' 19 32 12"
	for ARG in $CHANNELS_DI$CHANNELS_SKY$CHANNELS_CUSTOM; do
		MENUCMD="$MENUCMD $ARG ''"
	done
	CHANNEL=$(eval "$MENUCMD" 3>&1 1>&2 2>&3) || exit 1

	# Ask for the bitrate only when using premium.
	if [ -n "$PREMIUM" ]; then
		MENUCMD="dialog --backtitle $PROG --default-item $BITRATE"
		MENUCMD="$MENUCMD --menu 'Select the bitrate:' 11 32 4"
		MENUCMD="$MENUCMD 256 'MP3 256 kbit/s' 128 'AAC 128 kbit/s'"
		MENUCMD="$MENUCMD 64 'AAC  64 kbit/s' 40 'AAC  40 kbit/s'"
		BITRATE=$(eval "$MENUCMD" 3>&1 1>&2 2>&3) || exit 1
	fi

	echo
fi

# Construct the URL of the playlist.
case $CHANNELS_DI in
	*" $CHANNEL "*)
		WEBSITE=di
		;;
	*)
		case $CHANNELS_SKY in
			*" $CHANNEL "*)
				WEBSITE=sky
				;;
			*)
				WEBSITE=custom
				;;
		esac
		;;
esac
case $WEBSITE$BITRATE in
	di256)   URL="http://listen.di.fm/premium_high/$CHANNEL.pls?$PREMIUM" ;;
	di128)   URL="http://listen.di.fm/premium/$CHANNEL.pls?$PREMIUM" ;;
	di64)    URL="http://listen.di.fm/premium_medium/$CHANNEL.pls?$PREMIUM" ;;
	di40)    URL="http://listen.di.fm/premium_low/$CHANNEL.pls?$PREMIUM" ;;
	difree)  URL="http://listen.di.fm/public3/$CHANNEL.pls" ;;
	sky256)  URL="http://listen.sky.fm/premium_high/$CHANNEL.pls?$PREMIUM" ;;
	sky128)  URL="http://listen.sky.fm/premium/$CHANNEL.pls?$PREMIUM" ;;
	sky64)   URL="http://listen.sky.fm/premium_medium/$CHANNEL.pls?$PREMIUM" ;;
	sky40)   URL="http://listen.sky.fm/premium_low/$CHANNEL.pls?$PREMIUM" ;;
	skyfree) URL="http://listen.sky.fm/public3/$CHANNEL.pls" ;;
	custom*)
		# Set URL from MY_URLS so that there is exactly one space
		# between URLs and no space in the beginning or end of
		# the string.
		URL=$(echo "$MY_URLS" | tr '[:space:]' ' ' \
				| sed 's/ \{1,\}/ /g;s/^ *//;s/ *$//')

		# Set I to contain as many spaces as the index of the selected
		# custom channel is.
		I=$(echo "${CHANNELS_CUSTOM%" $CHANNEL "*}" | tr -dc ' ')

		# Remove as many URLs from the beginning of the $URL as there
		# are spaces in $I.
		while [ -n "$I" ]; do
			I=${I%' '}
			URL=${URL#*' '}
		done

		# Remove the trailing URLs.
		URL=${URL%%' '*}
		;;
esac

# Try to play it.
exec $PLAYER "$URL"

# Just in case it failed, make sure we give a reasonable exit status.
exit 1
