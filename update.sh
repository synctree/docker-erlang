#!/bin/bash
set -eo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( */ )
fi
versions=( "${versions[@]%/}" )

for version in "${versions[@]}"; do
	dist="$(grep '^FROM ' "$version/Dockerfile" | cut -d' ' -f2 | sed -r 's/^(ubuntu|debian)://')"
	package="$(grep -m1 '="$ERLANG_VERSION"' "$version/Dockerfile" | cut -d= -f1 | sed -r 's/^\s+//g; s/\s+$//g')"
	packagesUrl="http://packages.erlang-solutions.com/debian/dists/$dist/contrib/binary-amd64/Packages"
	packages="$(echo "$packagesUrl" | sed -r 's/[^a-zA-Z.-]+/-/g')"
	(set -x; curl -SL "${packagesUrl}.bz2" | bunzip2 > "$packages")

	majorVersion="1:${version#R}"
	fullVersion="$(set -x; grep -A10 "^Package: $package\$" "$packages" | grep "^Version: ${majorVersion}\>" | cut -d' ' -f2 | sort -Vr | head -1)"
	if [ "$fullVersion" ]; then
		dockerfiles="$(find "$version" -name Dockerfile)"
		(
			set -x
			sed -ri '
				s/(ENV ERLANG_VERSION) .*/\1 '"$fullVersion"'/g;
			' $dockerfiles
		)
	else
		echo 2>&1 "Failed to determine full package version for package $version"
		rm "$packages"
		exit 1
	fi

	rm "$packages"
done
