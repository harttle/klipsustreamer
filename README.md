# CLI clipboard for OSX

A simple and lightweight CLI tool to query and set clipboard, more flexible and raw than tools like pbcopy/pngpaste. Features:

* Get clipboard changeCount and available Types
* Get clipboard content by Type
* Set clipboard content by Type

## Usage

Install to your OSX:

```bash
sudo wget https://github.com/harttle/osxclipboard/raw/master/osxclipboard -O /usr/local/bin/osxclipboard && sudo chmod a+rx /usr/local/bin/osxclipboard
```

Print help message:

```bash
> osxclipboard --help
Usage:
  -h, --help	Show help
  -c, --count	Show clipboard change count
  -i, --input <type>	Set clipboard by type with content from stdin
  -o, --output <type>	Output clipboard content by type
  -s, --status	Show clipboard information
```

Print clipboard changeCount and available types(for performance reason, json output is not pretified by default, here we pipe the output to jq):

```bash
> osxclipboard --status | jq
{
  "count": 97,
  "types": [
    "public.tiff",
    "NeXT TIFF v4.0 pasteboard type",
    "com.trolltech.anymime.application--x-qt-image"
  ]
}
```

Write and read:

```bash
> echo -n foo | osxclipboard -i public.utf8-plain-text
> osxclipboard -o public.utf8-plain-text
foo
```
