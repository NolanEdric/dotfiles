#!/usr/bin/env bash

ps -eo 'tty,pid,comm' | grep ^?
