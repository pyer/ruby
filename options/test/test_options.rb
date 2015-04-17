require "minitest/autorun"
require './lib/options.rb'

class TestOptions < Minitest::Test

    def test_run
      args = ['-v']
      dbg = false
      opts = Options.parse(args) do
        run do
          dbg = true
        end
        option  'verbose', 'Enable verbose mode'
      end
      assert( opts.verbose )
      assert( dbg )
    end

    def test_command
      args = ['get']
      opts = Options.parse(args) do
        command 'get', 'Get value'
        command 'set', 'Set value'
        command :put,  'Put value'
        option  'verbose', 'Enable verbose mode'
      end
      assert_equal( opts.command, 'get' )
    end

    def test_command_with_block
      args = ['get']
      opts = Options.parse(args) do
        command 'get', 'Get value' do
          "GET callback"
        end
        command 'set', 'Set value' do
          "SET callback"
        end
        option  'verbose', 'Enable verbose mode'
      end
      assert_equal( opts.callback, "GET callback" )
    end

    def test_invalid_command
      args = ['get']
      assert_raises(Options::InvalidCommandError) {
        opts = Options.parse(args) do
          command '-get', 'Get value'
          option  'verbose', 'Enable verbose mode'
        end
      }
    end

    def test_unknown_command
      args = ['-v']
      assert_raises(Options::UnknownCommandError) {
        opts = Options.parse(args) do
          command 'get', 'Get value'
          command 'set', 'Set value'
          option  'verbose', 'Enable verbose mode'
        end
      }
    end

    def test_invalid_command_order
      # command must be the first argument
      args = ['-v', 'get']
      assert_raises(Options::UnknownCommandError) {
        opts = Options.parse(args) do
          command 'get', 'Get value'
          command 'set', 'Set value'
          option  'verbose', 'Enable verbose mode'
        end
      }
    end

    def test_unknown_command
      args = ['other']
      assert_raises(Options::UnknownCommandError) {
        opts = Options.parse(args) do
          command 'get', 'Get value'
          command 'set', 'Set value'
          option  'verbose', 'Enable verbose mode'
        end
      }
    end

    def test_command_and_option
      args = ['get', '-v']
      opts = Options.parse(args) do
        command 'get', 'Get value'
        command 'set', 'Set value'
        option  'verbose', 'Enable verbose mode'
        option  'id=', 'Identification'
      end
      assert( opts.verbose? )
    end

    def test_simple_option1
      args = ['-i']
      opts = Options.parse(args) do
        on 'id', 'Identification'
      end
      assert( opts.id? )
    end

    def test_simple_option2
      args = ['--id']
      opts = Options.parse(args) do
        on 'id', 'Identification'
      end
      assert( opts.id? )
    end

    def test_simple_option3
      args = ['-i']
      opts = Options.parse(args) do
        on '--id', 'Identification'
      end
      assert( opts.id? )
    end

    def test_simple_option4
      args = ['-i', '123']
      opts = Options.parse(args) do
        on 'id=ID', 'Identification'
      end
      assert_equal( opts[:id], "123" )
    end

    def test_simple_option4
      args = ['-i', '123']
      opts = Options.parse(args) do
        on 'id=ID', 'Identification'
      end
      assert_equal( opts.id, "123" )
    end

    def test_option_with_block
      args = ['-d']
      dbg = false
      opts = Options.parse(args) do
        option 'debug', 'Enable debug mode' do
          dbg = true
        end
      end
      assert( opts.debug )
      assert( dbg )
    end

    def test_banner
      args = ['-v']
      opts = Options.parse(args) do
        banner 'Banner'
        option 'verbose', 'Enable verbose mode'
      end
      assert_equal( opts.banner, "Banner\n" )
    end

    def test_banner2
      args = ['-v']
      opts = Options.parse(args) do
        banner 'Line1'
        banner 'Line2'
        option 'verbose', 'Enable verbose mode'
      end
      assert_equal( opts.banner, "Line1\nLine2\n" )
    end

    def test_help
      args = ['-v']
      opts = Options.parse(args) do
        on 'verbose', 'Enable verbose mode'
      end
      assert( opts.help.is_a? String )
      #puts ""
      #puts opts.help
    end

    def test_true_flag1
      args = ['-v']
      opts = Options.parse(args) do
        on 'verbose', 'Enable verbose mode'
      end
      assert( opts.verbose? )
    end

    def test_true_flag2
      args = ['-v']
      opts = Options.parse(args) do
        on 'verbose', 'Enable verbose mode'
      end
      assert( opts[:verbose] )
    end

    def test_false_flag1
      args = ['-d']
      opts = Options.parse(args) do
        on 'debug', 'Enable debug mode'
        on 'verbose', 'Enable verbose mode'
      end
      refute( opts.verbose? )
    end

    def test_false_flag2
      args = ['-d']
      opts = Options.parse(args) do
        on 'debug', 'Enable debug mode'
        on 'verbose', 'Enable verbose mode'
      end
      refute( opts[:verbose] )
    end

    def test_unknown_flag1
      args = ['-v']
      opts = Options.parse(args) do
        on 'verbose', 'Enable verbose mode'
      end
      refute( opts.dummy? )
    end

    def test_unknown_flag2
      args = ['-v']
      opts = Options.parse(args) do
        on 'verbose', 'Enable verbose mode'
      end
      assert( opts[:dummy].nil? )
    end

    def test_wrong_number_of_arguments_of_option1
      # Help string is mandatory
      args = ['-v']
      assert_raises(ArgumentError) {
        opts = Options.parse(args) do
          on 'verbose'
        end
      }
    end

    def test_wrong_number_of_arguments_of_option2
      args = ['-v']
      assert_raises(ArgumentError) {
        opts = Options.parse(args) do
          on 'verbose', 'Enable verbose mode', 'extra'
        end
      }
    end

    def test_unknown_option
      args = ['--option','-v']
      assert_raises(Options::UnknownOptionError) {
        opts = Options.parse(args) do
          on 'help', 'Show some help'
          on 'verbose', 'Enable verbose mode'
        end
      }
    end

    def test_missing_option
      args = ['--name','Pierre']
      opts = Options.parse(args) do
        on 'name=', 'Enter your name'
        on 'id=', 'Enter your ID'
      end
      refute( opts.id? )
    end

    def test_missing_option_is_nil
      args = ['--name','Pierre']
      opts = Options.parse(args) do
        on 'name=', 'Enter your name'
        on 'id=', 'Enter your ID'
      end
      assert_nil( opts[:id] )
    end

    def test_valid_argument
      args = ['--name','Pierre']
      opts = Options.parse(args) do
        on 'name=', 'Enter your name'
      end
      assert_equal( opts[:name], "Pierre" )
    end

    def test_undefined_argument
      args = ['-v']
      opts = Options.parse(args) do
        on 'name=', 'Enter your name'
        on 'verbose', 'Enable verbose mode'
      end
      refute( opts.name? )
    end

    def test_missing_argument
      args = ['--name']
      assert_raises(Options::MissingArgumentError) {
        opts = Options.parse(args) do
          on 'name=', 'Enter your name'
        end
      }
    end

    def test_invalid_argument
      args = ['--name', '-v']
      assert_raises(Options::InvalidArgumentError) {
        opts = Options.parse(args) do
          on 'name=', 'Enter your name'
          on 'verbose', 'Enable verbose mode'
        end
      }
    end

    def test_mix_option
      args = ['-verbose'] # is allowed
      assert_raises(Options::InvalidOptionError) {
        opts = Options.parse(args) do
          on 'help', 'Show some help'
          on 'verbose', 'Enable verbose mode'
        end
      }
    end

    def test_short_option
      args = ['-v']
      opts = Options.parse(args) do
        on 'help', 'Show some help'
        on 'verbose', 'Enable verbose mode'
      end
      assert( opts.verbose? )
    end

    def test_long_option
      args = ['--verbose']
      opts = Options.parse(args) do
        on 'help', 'Show some help'
        on 'verbose', 'Enable verbose mode'
      end
      assert( opts.verbose? )
    end

    def test_missing_short_option
      args = ['-v']
      opts = Options.parse(args) do
        on 'dummy', 'Dummy option'
        on 'help', 'Show some help'
        on 'verbose', 'Enable verbose mode'
        on 'zzz', 'Z as Zero'
      end
#      p opts.missing
      assert( opts.missing == ['dummy', 'help', 'zzz'] )
    end

    def test_missing_long_option
      args = ['--verbose']
      opts = Options.parse(args) do
        on 'dummy', 'Dummy option'
        on 'help', 'Show some help'
        on 'verbose', 'Enable verbose mode'
        on 'zzz', 'Z as Zero'
      end
#      p opts.missing
      assert( opts.missing == ['dummy', 'help', 'zzz'] )
    end

end
