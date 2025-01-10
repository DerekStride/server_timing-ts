# ServerTiming

Ruby wrapper for [tree-sitter-server_timing](https://github.com/DerekStride/tree-sitter-server_timing), a parser for the
[Server-Timing](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Server-Timing) header.

## Usage

```bash
bin/setup
bin/console
```

The setup script will run run `bundle install` then compile the
[tree-sitter-server_timing](https://github.com/DerekStride/tree-sitter-server_timing) parser and place the `.dylib` /
`.so` file in the `treesitter/` directory.

The console script will load the gem and the parser and drop you into an [IRB](https://github.com/ruby/irb) session.

### Example

```ruby
include ServerTiming

header = get_header("https://derek.stride.host")
tree = parse(header)
timings = extract_timings(tree)
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ServerTiming project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/DerekStride/server_timing-ts/blob/main/CODE_OF_CONDUCT.md).
