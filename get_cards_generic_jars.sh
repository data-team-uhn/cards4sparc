#!/bin/bash

# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

GENERIC_CARDS_DOCKER_IMAGE="ghcr.io/data-team-uhn/cards:latest-generic"

mkdir .cards-generic-mvnrepo

# Copy the files from the generic CARDS Docker image ~/.m2 directory to this local .cards-generic-mvnrepo directory
docker run \
	--rm \
	-v $(realpath .cards-generic-mvnrepo):/cards-generic-mvnrepo \
	-e HOST_UID=$UID \
	-e HOST_GID=$(id -g) \
	--network none \
	--entrypoint /bin/sh \
	-it $GENERIC_CARDS_DOCKER_IMAGE -c 'cp -r /root/.m2/repository /cards-generic-mvnrepo && chown -R ${HOST_UID}:${HOST_GID} /cards-generic-mvnrepo'
