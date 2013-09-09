#!/usr/bin/env python
import zephyros

def push_up():
    win = zephyros.api.focused_window()
    screen = win.screen()
    frame = screen.frame_without_dock_or_menu()
    frame.h /= 2
    frame.inset(10, 10)
    win.set_frame(frame)

def push_down():
    win = zephyros.api.focused_window()
    screen = win.screen()
    frame = screen.frame_without_dock_or_menu()
    frame.y += frame.h / 2
    frame.h /= 2
    frame.inset(10, 10)
    win.set_frame(frame)

def push_left():
    win = zephyros.api.focused_window()
    screen = win.screen()
    frame = screen.frame_without_dock_or_menu()
    frame.w /= 2
    frame.inset(10, 10)
    win.set_frame(frame)

def push_right():
    win = zephyros.api.focused_window()
    screen = win.screen()
    frame = screen.frame_without_dock_or_menu()
    frame.x += frame.w / 2
    frame.w /= 2
    frame.inset(10, 10)
    win.set_frame(frame)

def max_window():
    win = zephyros.api.focused_window()
    screen = win.screen()
    frame = screen.frame_without_dock_or_menu()
    frame.inset(10, 10)
    win.set_frame(frame)

def center_window():
    win = zephyros.api.focused_window()
    wframe = win.frame()

    screen = zephyros.api.main_screen()
    sframe = screen.frame_without_dock_or_menu()

    frame = zephyros.Rect()
    frame.x = (sframe.w - wframe.w) / 2
    frame.y = (sframe.h - wframe.h) / 2
    frame.w = wframe.w
    frame.h = wframe.h

    win.set_frame(frame)

def nudge_window():
    win = zephyros.api.focused_window()
    frame = win.frame()
    frame.x -= 3
    win.set_frame(frame)

def reset_config():
    zephyros.api.relaunch_config()

@zephyros.zephyros
def configuration():
    mash = ['Alt', 'Cmd']
    mash2 = ['Ctrl', 'Alt', 'Cmd']
    zephyros.api.bind('k', mash, push_up)
    zephyros.api.bind('j', mash, push_down)
    zephyros.api.bind('h', mash, push_left)
    zephyros.api.bind('l', mash, push_right)
    zephyros.api.bind('m', mash, max_window)
    zephyros.api.bind('c', mash, center_window)
    zephyros.api.bind('h', mash2, nudge_window)
    zephyros.api.bind('r', mash, reset_config)
