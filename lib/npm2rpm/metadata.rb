#
# npm2rpm/lib/metadata.rb
#
# Implements access to npmjs.org module metadata
#


# Metadata represents npmjs.org metadata
# {
#  "_id": "grunt-contrib-jshint",
#  "_rev": "50-de057965aacb5d6a72a6b06df06af685",
#  "name": "grunt-contrib-jshint",
#  "description": "Validate files with JSHint.",
#  "dist-tags": {
#    "latest": "0.6.4"
#  },
#  "readme": "# grunt-contrib-jshint [![Build Status](https://secure.travis-ci.org/gruntjs/grunt-contrib-jshint.png?branch=master)](http://travis-ci.org/gruntjs/grunt-contrib-jshint)\n\n> Validate files with JSHint.\n\n_Note that this plugin has not yet been released, and only works with the latest bleeding-edge, in-development version of grunt. See the [When will I be able to use in-development feature 'X'?](https://github.com/gruntjs/grunt/blob/devel/docs/faq.md#when-will-i-be-able-to-use-in-development-feature-x) FAQ entry for more information._\n\n## Getting Started\nIf you haven't used [grunt][] before, be sure to check out the [Getting Started][] guide, as it explains how to create a [gruntfile][Getting Started] as well as install and use grunt plugins. Once you're familiar with that process, install this plugin with this command:\n\n`shell\nnpm install grunt-contrib-jshint --save-dev\n`\n\n[grunt]: http://gruntjs.com/\n[Getting Started]: https://github.com/gruntjs/grunt/blob/devel/docs/getting_started.md\n\n\n## Jshint task\n_Run this task with the grunt jshint command._\n\n_This task is a [multi task][] so any targets, files and options should be specified according to the [multi task][] documentation._\n[multi task]: https://github.com/gruntjs/grunt/wiki/Configuring-tasks\n\n\n### Options\n\nAny specified option will be passed through directly to [JSHint][], thus you can specify any option that JSHint supports. See the [JSHint documentation][] for a list of supported options.\n\n[JSHint]: http://www.jshint.com/\n[JSHint documentation]: http://www.jshint.com/docs/\n\nA few additional options are supported:\n\n#### globals\nType: Object\nDefault value: null\n\nA map of global variables, with keys as names and a boolean value to determine if they are assignable. This is not a standard JSHint option, but is passed into the JSHINT function as its third argument. See the [JSHint documentation][] for more information.\n\n#### jshintrc\nType: String\nDefault value: null\n\nIf this filename is specified, options and globals defined therein will be used. The jshintrc file must be valid JSON and looks something like this:\n\n`json\n{\n  \"curly\": true,\n  \"eqnull\": true,\n  \"eqeqeq\": true,\n  \"undef\": true,\n  \"globals\": {\n    \"jQuery\": true\n  }\n}\n`\n\n### Usage examples\n\n#### Wildcards\nIn this example, running grunt jshint:all (or grunt jshint because jshint is a [multi task][]) will lint the project's Gruntfile as well as all JavaScript files in the lib and test directories and their subdirectores, using the default JSHint options.\n\n`js\n// Project configuration.\ngrunt.initConfig({\n  jshint: {\n    all: ['Gruntfile.js', 'lib/**/*.js', 'test/**/*.js']\n  }\n});\n`\n\n#### Linting before and after concatenating\nIn this example, running grunt jshint will lint both the \"beforeconcat\" set and \"afterconcat\" sets of files. This is not ideal, because dist/output.js may get linted before it gets created via the [grunt-contrib-concat plugin](https://github.com/gruntjs/grunt-contrib-concat) concat task.\n\nIn this case, you should lint the \"beforeconcat\" files first, then concat, then lint the \"afterconcat\" files, by running grunt jshint:beforeconcat concat jshint:afterconcat.\n\n`js\n// Project configuration.\ngrunt.initConfig({\n  concat: {\n    dist: {\n      src: ['src/foo.js', 'src/bar.js'],\n      dest: 'dist/output.js'\n    }\n  },\n  jshint: {\n    beforeconcat: ['src/foo.js', 'src/bar.js'],\n    afterconcat: ['dist/output.js']\n  }\n});\n`\n\n#### Specifying JSHint options and globals\n\nIn this example, custom JSHint options are specified. Note that when grunt jshint:uses_defaults is run, those files are linted using the default options, but when grunt jshint:with_overrides is run, those files are linted using _merged_ task/target options.\n\n`js\n// Project configuration.\ngrunt.initConfig({\n  jshint: {\n    options: {\n      curly: true,\n      eqeqeq: true,\n      eqnull: true,\n      browser: true,\n      globals: {\n        jQuery: true\n      },\n    },\n    uses_defaults: ['dir1/**/*.js', 'dir2/**/*.js'],\n    with_overrides: {\n      options: {\n        curly: false,\n        undef: true,\n      },\n      files: {\n        src: ['dir3/**/*.js', 'dir4/**/*.js']\n      },\n    }\n  },\n});\n`\n\n\n## Release History\n\n * 2012-10-17   v0.1.0   Work in progress, not yet officially released.\n\n---\n\nTask submitted by [\"Cowboy\" Ben Alman](http://benalman.com/)\n\n*This file was generated on Wed Nov 28 2012 08:49:23.*\n",
#  "maintainers": [
#   {
#     "name": "cowboy",
#     "email": "cowboy@rj3.net"
#   },
#   ...
#   ],
#   "time": {
#    "0.1.0": "2013-01-08T18:41:18.246Z",
#    ...
#   },
#  "author": {
#    "name": "Grunt Team",
#    "url": "http://gruntjs.com/"
#  },
#  "repository": {
#   "type": "git",
#   "url": "git://github.com/gruntjs/grunt-contrib-jshint.git"
#  },
#  "users": {
#   "paazmaya": true,
#   ...
#  },
#  "_attachments": {
#   "grunt-contrib-jshint-0.6.4.tgz": {
#    "content_type": "application/octet-stream",
#    "revpos": 48,
#    "digest": "md5-LEuyQStwm+KcTmtVkwapDQ==",
#    "length": 9834,
#    "stub": true
#   },
#   ...
#  },
#  "versions": {
#
# == Versions
#     "0.1.0": {
#           "name": "grunt-contrib-jshint",
#           "description": "Validate files with JSHint.",
#           "version": "0.1.0",
#           "homepage": "https://github.com/gruntjs/grunt-contrib-jshint",
#           "author": {
#             "name": "\"Cowboy\" Ben Alman",
#             "email": "cowboy@rj3.net",
#             "url": "http://gruntjs.com/"
#           },
#           "repository": {
#             "type": "git",
#             "url": "git://github.com/gruntjs/grunt-contrib-jshint.git"
#           },
#           "bugs": {
#             "url": "https://github.com/gruntjs/grunt-contrib-jshint/issues"
#           },
#           "licenses": [
#           {
#             "type": "MIT",
#             "url": "https://github.com/gruntjs/grunt-contrib-jshint/blob/master/LICENSE-MIT"
#           }
#           ],
#           "main": "Gruntfile.js",
#           "engines": {
#             "node": ">= 0.8.0"
#           },
#           "dependencies": {
#             "jshint": "~0.9.0"
#           },
#           "devDependencies": {
#             "grunt-contrib-nodeunit": "~0.1.0",
#             "grunt-contrib-internal": "~0.1.0",
#             "grunt": "~0.4.0"
#           },
#       "keywords": [],
#           "contributors": [
#           {
#             "name": "\"Cowboy\" Ben Alman",
#             "url": "http://benalman.com/"
#           },
#           {
#             "name": "Tyler Kellen",
#             "url": "http://goingslowly.com/"
#           }
#           ],
#           "readme": "# grunt-contrib-jshint [![Build Status](https://secure.travis-ci.org/gruntjs/grunt-contrib-jshint.png?branch=master)](http://travis-ci.org/gruntjs/grunt-contrib-jshint)\n\n> Validate files with JSHint.\n\n_Note that this plugin has not yet been released, and only works with the latest bleeding-edge, in-development version of grunt. See the [When will I be able to use in-development feature 'X'?](https://github.com/gruntjs/grunt/blob/devel/docs/faq.md#when-will-i-be-able-to-use-in-development-feature-x) FAQ entry for more information._\n\n## Getting Started\nIf you haven't used [grunt][] before, be sure to check out the [Getting Started][] guide, as it explains how to create a [gruntfile][Getting Started] as well as install and use grunt plugins. Once you're familiar with that process, install this plugin with this command:\n\n`shell\nnpm install grunt-contrib-jshint --save-dev\n`\n\n[grunt]: http://gruntjs.com/\n[Getting Started]: https://github.com/gruntjs/grunt/blob/devel/docs/getting_started.md\n\n\n## Jshint task\n_Run this task with the grunt jshint command._\n\n_This task is a [multi task][] so any targets, files and options should be specified according to the [multi task][] documentation._\n[multi task]: https://github.com/gruntjs/grunt/wiki/Configuring-tasks\n\n\n### Options\n\nAny specified option will be passed through directly to [JSHint][], thus you can specify any option that JSHint supports. See the [JSHint documentation][] for a list of supported options.\n\n[JSHint]: http://www.jshint.com/\n[JSHint documentation]: http://www.jshint.com/docs/\n\nA few additional options are supported:\n\n#### globals\nType: Object\nDefault value: null\n\nA map of global variables, with keys as names and a boolean value to determine if they are assignable. This is not a standard JSHint option, but is passed into the JSHINT function as its third argument. See the [JSHint documentation][] for more information.\n\n#### jshintrc\nType: String\nDefault value: null\n\nIf this filename is specified, options and globals defined therein will be used. The jshintrc file must be valid JSON and looks something like this:\n\n`json\n{\n  \"curly\": true,\n  \"eqnull\": true,\n  \"eqeqeq\": true,\n  \"undef\": true,\n  \"globals\": {\n    \"jQuery\": true\n  }\n}\n`\n\n### Usage examples\n\n#### Wildcards\nIn this example, running grunt jshint:all (or grunt jshint because jshint is a [multi task][]) will lint the project's Gruntfile as well as all JavaScript files in the lib and test directories and their subdirectores, using the default JSHint options.\n\n`js\n// Project configuration.\ngrunt.initConfig({\n  jshint: {\n    all: ['Gruntfile.js', 'lib/**/*.js', 'test/**/*.js']\n  }\n});\n`\n\n#### Linting before and after concatenating\nIn this example, running grunt jshint will lint both the \"beforeconcat\" set and \"afterconcat\" sets of files. This is not ideal, because dist/output.js may get linted before it gets created via the [grunt-contrib-concat plugin](https://github.com/gruntjs/grunt-contrib-concat) concat task.\n\nIn this case, you should lint the \"beforeconcat\" files first, then concat, then lint the \"afterconcat\" files, by running grunt jshint:beforeconcat concat jshint:afterconcat.\n\n`js\n// Project configuration.\ngrunt.initConfig({\n  concat: {\n    dist: {\n      src: ['src/foo.js', 'src/bar.js'],\n      dest: 'dist/output.js'\n    }\n  },\n  jshint: {\n    beforeconcat: ['src/foo.js', 'src/bar.js'],\n    afterconcat: ['dist/output.js']\n  }\n});\n`\n\n#### Specifying JSHint options and globals\n\nIn this example, custom JSHint options are specified. Note that when grunt jshint:uses_defaults is run, those files are linted using the default options, but when grunt jshint:with_overrides is run, those files are linted using _merged_ task/target options.\n\n`js\n// Project configuration.\ngrunt.initConfig({\n  jshint: {\n    options: {\n      curly: true,\n      eqeqeq: true,\n      eqnull: true,\n      browser: true,\n      globals: {\n        jQuery: true\n      },\n    },\n    uses_defaults: ['dir1/**/*.js', 'dir2/**/*.js'],\n    with_overrides: {\n      options: {\n        curly: false,\n        undef: true,\n      },\n      files: {\n        src: ['dir3/**/*.js', 'dir4/**/*.js']\n      },\n    }\n  },\n});\n`\n\n\n## Release History\n\n * 2012-10-17   v0.1.0   Work in progress, not yet officially released.\n\n---\n\nTask submitted by [\"Cowboy\" Ben Alman](http://benalman.com/)\n\n*This file was generated on Wed Nov 28 2012 08:49:23.*\n",
#           "_id": "grunt-contrib-jshint@0.1.0",
#           "dist": {
#             "shasum": "d2a2ab3495dae72f1d2b10d67ade598e3f66ddd8",
#             "tarball": "http://registry.npmjs.org/grunt-contrib-jshint/-/grunt-contrib-jshint-0.1.0.tgz"
#           },
#           "_npmVersion": "1.1.62",
#           "_npmUser": {
#             "name": "cowboy",
#             "email": "cowboy@rj3.net"
#           },
#           "maintainers": [
#           {
#             "name": "cowboy",
#             "email": "cowboy@rj3.net"
#           }
#           ],
#           "directories": {}
#         },
#

require 'json'

module Npm2Rpm

  class Metadata
    # npmdata is version-specific information
    attr_reader :name, :npmdata    
    def initialize name, version = nil
      # Get details from central NPM repository
      # FIXME: Server returns... not quite JSON.
      @metaurl = "https://registry.npmjs.org/#{name}"
      
      json = Download.new(@metaurl).content
      # $metadata_json =~ s/\b([^"':\s]+)(:\s+)/"$1"$2/gm;
      # $metadata_json =~ s/'/"/gm;
      @metadata = JSON.parse json
      @version = version || @metadata["dist-tags"]["latest"] || abort("Can't determine version")
      puts "#{name}-#{@version}"
      @npmdata = @metadata["versions"][@version] || abort("No such version: #{@version.inspect}")
      @name = @metadata["name"]
      abort("Name mismatch, want #{name.inspect}, got #{@name.inspect}") unless name == @name
    end
    
    def tarball
      @npmdata["dist"]["tarball"]
    end

    def licenses
      @npmdata['licenses']
    end

    def srcversion
      @srcversion ||= @version
    end

    def pkgversion
      @pkgversion ||= @version.tr('-', '_')
    end

    def method_missing name, *args
      raise "Use srcversion or pkgversion" if name == :version
      result = @metadata[name.to_s]
      while args
        s = args.shift
        case result
        when Hash
          result = result[s.to_s]
        else
          result = nil
          break
        end
      end
      result
    end
  end

end
