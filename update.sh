#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( */ )
fi
versions=( "${versions[@]%/}" )

packagesUrl='http://packages.erlang-solutions.com/debian/dists/wheezy/contrib/binary-amd64/Packages'
packages="$(echo "$packagesUrl" | sed -r 's/[^a-zA-Z.-]+/-/g')"
curl -sSL "${packagesUrl}.bz2" | bunzip2 > "$packages"

for version in "${versions[@]}"; do
	majorVersion="1:${version#R}"
	fullVersion="$(grep -A10 '^Package: erlang-base$' "$packages" | grep "^Version: ${majorVersion}\>" | cut -d' ' -f2 | sort -Vr | head -1)"
	if [ "$fullVersion" ]; then
		(
			set -x
			sed -ri '
				s/(ENV ERLANG_VERSION) .*/\1 '"$fullVersion"'/g;
			' "$version/"{,slim/}Dockerfile
		)
	fi
done

rm "$packages"
