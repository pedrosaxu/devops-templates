#!/bin/bash
interpreter="node"

if pgrep $interpreter; then
	pkill $interpreter
else
        echo 'Nao existe'
fi
