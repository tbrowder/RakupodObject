[![Actions Status](https://github.com/tbrowder/RakupodObject/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/RakupodObject/actions) [![Actions Status](https://github.com/tbrowder/RakupodObject/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/RakupodObject/actions) [![Actions Status](https://github.com/tbrowder/RakupodObject/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/RakupodObject/actions)

NAME
====

**RakupodObject** - Provides a routine to extract the '$=pod' object from an external Rakupod source (a file or a string)

SYNOPSIS
========

```raku
use RakupodObject;
my $pod-object = extract-rakupod-object $file;
```

DESCRIPTION
===========

**RakupodObject** is a module that enables easy access to the Rakupod object represented by the Raku variable `$=pod`. That variable, which is a `Pod::Block` object, holds the complete, compiled Rakupod tree extracted from a Raku source file (or string). (It is the same as the `$=pod` object used by code inside that source file.)

It is used by external programs whose purpose is to process the Rakupod into other objects, primarily other forms of documentation. See the Raku docs for a complete description of the various `Pod::Block` subtypes and their attributes.

The module exports one subroutine:.

    sub extract-rakupod-object(
        $pod-source # file or string
        --> Pod::Block
    ) is export  {...}

Warning
=======

The exported routine uses pragma `MONKEY-SEE-NO-EVAL` so, as is mentioned in the Raku docs, the user is warned of the possibility of system compromise with malicious code in the `EVAL`ed string.

Credits
=======

The author is indebted to the Raku expert **Vadim Belman** (AKA `@vrurg`) who provided the routine during the construction of some Rakupod tests several years ago. The routine, in its original form, can be seen in file [https://github.com/raku/roast/blob/master/S26-documentation/12-non-breaking-space.t](https://github.com/raku/roast/blob/master/S26-documentation/12-non-breaking-space.t).

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2022-2024 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

