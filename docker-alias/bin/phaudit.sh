#!/bin/bash
if service docker status 2&>1 > /dev/null; then
	docker run -t -i -v /:/host jolicode/phaudit $1 /host/$2
else
	cmd/echo-error "The Docker deamon is not running! Start it please."
fi
