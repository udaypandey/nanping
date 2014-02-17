Nanping
=======

plist tweaks for ios builds

## Installation

    $ gem install nanping

## Usage

Provides few extra commands for ios build related to plist changes. Inspired from [Shenzhen](https://github.com/nomad/shenzhen)

nanping adds the `iosbuild` command to your PATH:

    $ iosbuild

      Build and distribute iOS apps (.ipa files)

      Commands:
         help                 Display global or [command] help documentation.
         plist:buildnumber    Update build number properties in application plist file
         plist:configure      Update properties in application plist file
         plist:read           Read properties in application plist file

      Aliases:

      Global Options:
        -h, --help           Display help documentation
        -v, --version        Display version information
        -t, --trace          Display backtrace when an error occurs

### Example Usage

        $ cd /path/to/iOS Project/
        $ iosbuild plist:buildnumber    --file "$PLIST_FILE" \
                                        --infix Trial
                                        --buildnumber $JENKINS_BUILD_NUMBER
        $ iosbuild plist:configure      --file "$PLIST_FILE" \
                                        CFBundleDisplayName='Hours Trial' \
                                        CFBundleIdentifier=com.thirstysea.trial.hours 

## Contact

Uday Pandey

- http://github.com/udaypandey
- uday.pandey@gmail.com

## License

Nanping is available under the MIT license. See the LICENSE file for more info.
