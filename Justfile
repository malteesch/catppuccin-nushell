# print help page
[group('help')]
help:
    @just --list

# build the template to generate .nu files
[group('build')]
build:
    @whiskers catppuccin.nu.tera > catppuccin.nu

# build and start a nu shell with the color config applied
[group('test')]
test: build
    @nu --config test_config.nu
