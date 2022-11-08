[![Actions Status](https://github.com/tbrowder/RakupodObject/actions/workflows/test.yml/badge.svg)](https://github.com/tbrowder/RakupodObject/actions)

NAME
====

**RakupodObject** - Provides a routine to extract the '$=pod' object from an external Rakupod source

SYNOPSIS
========

```raku
use RakupodObject;
```

DESCRIPTION
===========

**RakupodObject** is a module that enables easy access to the Rakupod object represented by the Raku variable `$=pod`. That variable (a `Pod::Block`) holds the compiled Rakupod tree in a Raku source file. It is used by external programs whose purpose is to process the Rakupod into other objects, primarily other forms of documentation. See the Raku docs for a complete description of the various `Pod::Block` subtypes and their attributes.

The module exports two multi subroutines.

  * multi sub extract-rakupod-object(IO::Path:D $pod-file --> Pod::Block) is export {...}

  * multi sub extract-rakupod-object(Str:D $pod-string --> Pod::Block) is export {...}

Warning
=======

The exported routines use pragma `MONKEY-SEE-NO-EVAL` so, as is mentioned in the Raku docs, the user is warned of the possibility of system compromise with malicious code in the `EVAL`ed string.

Credits
=======

The author is indebted to the Raku expert **Vadim Belman** (AKA `@vrurg`) who provided the routine during the construction of some Rakupod tests several years ago. The routine, in its original form, can be seen in file [https://github.com/raku/roast/blob/master/S26-documentation/12-non-breaking-space.t](https://github.com/raku/roast/blob/master/S26-documentation/12-non-breaking-space.t).

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2022 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

