# Pathfinder client gem for mruby

This repository contains Pathfinder client gem for mruby.

## Getting started

Install these dependencies:

- `libossp-uuid-dev`

Add this line on mruby `build_config.rb` before compilation.

```
...
conf.gem github: 'pathfinder-cm/mruby-pathfinder-client'
...
```

Then you can run `./minirake` to start the compilation process. The resulting binaries can be used to run mruby scripts to communicate with pathfinder.

For more info please consult [this][mruby-compile-guide] guide to compile mruby.

## Development Setup

Ensure that you are using Ubuntu or Ubuntu-derived OS with version `16.04` or greater with Pathfinder Mono installed. You can consult [this][pathfinder-mono-doc] guide to install it.

### Running tests

Compile mruby with these 2 gems enabled.

```
...
conf.gem github: 'iij/mruby-require'
conf.gem github: 'iij/mruby-mtest'
...
```

Run `mruby test/**`

## Getting Help

If you have any questions or feedback regarding mruby-pathfinder-client:

- [File an issue](https://github.com/pathfinder-cm/mruby-pathfinder-client/issues/new) for bugs, issues and feature suggestions.

Your feedback is always welcome.

## Further Reading

- [mruby documentation][mruby-doc]
- [Guide to compile mruby][mruby-compile-guide]
- [mrbgems documentation][mrbgems-doc]
- [pathfinder documentation][pathfinder-mono-doc]

[mruby-doc]: https://github.com/mruby/mruby/tree/master/doc
[mruby-compile-guide]: https://github.com/mruby/mruby/blob/master/doc/guides/compile.md
[mrbgems-doc]: https://github.com/mruby/mruby/blob/master/doc/guides/mrbgems.md
[pathfinder-mono-doc]: https://github.com/pathfinder-cm/pathfinder-mono

## License

MIT License, see [LICENSE](LICENSE).
