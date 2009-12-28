#!/bin/bash
# run specified command detached from shell
$@ & < /dev/null &> /dev/null
