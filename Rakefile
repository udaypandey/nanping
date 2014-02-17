require "bundler/setup"

gemspec = eval(File.read("nanping.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["nanping.gemspec"] do
  system "gem build nanping.gemspec"
end
