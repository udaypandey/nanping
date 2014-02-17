require 'fileutils'

command :'plist:configure' do |c|
  c.syntax = "ipa plist:configure [options] [key=value]"
  c.summary = "Update properties in application plist file"
  c.description = ""
  c.option '-f', '--file FILE', "project plist file for the build"

  c.action do |args, options|
    @file = options.file
    say_error "Missing or unspecified plist file" and abort unless @file and File.exist?(@file)
    @file = File.absolute_path(@file)

    args.each do |arg| 
      (plist_key, plist_value) = arg.split("=")
      if plist_key.nil? or plist_key.empty? or plist_value.nil? or plist_value.empty? then
        say_warning "invalid k/v pair #{@arg}" if $verbose
        next
      end

      plist_orig_value = `defaults read #{@file} #{plist_key} #{'2> /dev/null' unless $verbose}`
      plist_orig_value.strip!

      log "configure:plist", "key:#{plist_key}", "orig:#{(plist_orig_value || "not present")}", "new:#{plist_value}"

      say_error "configure:plist error updating k/v" and abort            unless system %{defaults write #{@file} #{plist_key} '#{plist_value}' #{'1> /dev/null' unless $verbose}}
      say_error "configure:plist error converting back to xml" and abort  unless system %{plutil -convert xml1 #{@file} #{'1> /dev/null' unless $verbose}}
    end

    say_ok "plist successfully updated"
  end
end

command :'plist:buildnumber' do |c|
  c.syntax = "ipa plist:buildnumber [options]"
  c.summary = "Update build number properties in application plist file"
  c.description = ""
  c.option '-f', '--file FILE', "project plist file for the build"
  c.option '-i', '--infix INFIX', "Infix if any for build identifier (Trial.Daily in 18.Trial.Daily.593)"
  c.option '-n', '--buildnumber NUMBER', "Running build number if any for build identifier (593 in 18.Trial.Daily.593)"

  c.action do |args, options|
    @file = options.file
    say_error "configure:buildnumber Missing or unspecified plist file" and abort unless @file and File.exist?(@file)
    @file = File.absolute_path(@file)

    @infix = options.infix
    say_error "configure:buildnumber Missing or unspecified build infix" and abort unless @infix 
    @infix.strip!
    say_error "configure:buildnumber Missing or unspecified build infix" and abort unless @infix and not (@infix.nil? or @infix.empty?)

    @buildnumber = options.buildnumber
    say_error "configure:buildnumber Missing or unspecified build number" and abort unless @buildnumber 
    @buildnumber.strip!
    say_error "configure:buildnumber Missing or unspecified build number" and abort unless @buildnumber and not (@buildnumber.nil? or @buildnumber.empty?)

    plist_key = 'CFBundleVersion'
    plist_orig_value = `defaults read #{@file} #{plist_key} #{'2> /dev/null' unless $verbose}`
    plist_orig_value.strip!
    say_error "plist:buildnumber error reading #{plist_key}" and abort unless plist_orig_value

    plist_value = plist_orig_value + ".#{@infix}.#{@buildnumber}"

    log "configure:plist:buildnumber", "key:#{plist_key}", "orig:#{(plist_orig_value || "not present")}", "new:#{plist_value}"

    say_error "plist:buildnumber error updating #{plist_key}" and abort unless system %{defaults write #{@file} #{plist_key} '#{plist_value}' #{'1> /dev/null' unless $verbose}}
    say_error "configure:plist error converting back to xml" and abort  unless system %{plutil -convert xml1 #{@file} #{'1> /dev/null' unless $verbose}}

    say_ok "plist:buildnumber successfully updated"
  end
end

command :'plist:read' do |c|
  c.syntax = "ipa configure:plist [options]"
  c.summary = "Read properties in application plist file"
  c.description = ""
  c.option '-f', '--file FILE', "project plist file for the build"

  c.action do |args, options|
    @file = options.file
    say_error "Missing or unspecified plist file" and abort unless @file and File.exist?(@file)
    @file = File.absolute_path(@file)

    args.each do |arg| 
      plist_orig_value = `defaults read #{@file} #{arg} #{'2> /dev/null' unless $verbose}`
      plist_orig_value.strip!
      say_ok plist_orig_value
    end
  end
end
