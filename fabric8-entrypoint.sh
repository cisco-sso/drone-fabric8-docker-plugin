#!/bin/sh
#
# Copyright © 2018 Cisco Systems, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -ex

if [ "$PLUGIN_SCRIPTS" != "" ] ; then
	/usr/local/bin/dockerd -g /var/lib/docker &
	sleep 5 # TODO: this is a very bad idea. Poll the docker daemon until it is started to ensures the daemon is ready to accept.
	/usr/local/bin/docker version
	/usr/local/bin/docker info
	PLUGIN_SCRIPTS_EXECUTE=$(echo $PLUGIN_SCRIPTS | sed -e "s/,/;/g")
	eval $PLUGIN_SCRIPTS_EXECUTE
fi