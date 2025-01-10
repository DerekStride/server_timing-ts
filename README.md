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

## Benchmarks

### YJIT disabled

```
➜ server_timing-ts ruby bin/bench
ruby 3.3.4 (2024-07-09 revision be1089c8ec) [arm64-darwin23]
Warming up --------------------------------------
           generated     1.537k i/100ms
         handwritten     7.498k i/100ms
Calculating -------------------------------------
           generated     15.196k (± 2.1%) i/s   (65.81 μs/i) -     76.850k in   5.059706s
         handwritten     69.302k (± 6.2%) i/s   (14.43 μs/i) -    344.908k in   5.001894s
```

### YJIT enabled

```
➜ server_timing-ts ruby --yjit bin/bench
ruby 3.3.4 (2024-07-09 revision be1089c8ec) +YJIT [arm64-darwin23]
Warming up --------------------------------------
           generated     1.695k i/100ms
         handwritten     8.195k i/100ms
Calculating -------------------------------------
           generated     16.974k (± 0.7%) i/s   (58.91 μs/i) -     86.445k in   5.092946s
         handwritten     81.783k (± 1.7%) i/s   (12.23 μs/i) -    409.750k in   5.011606s
```
## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ServerTiming project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/DerekStride/server_timing-ts/blob/main/CODE_OF_CONDUCT.md).
