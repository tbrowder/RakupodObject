#!/bin/env raku

use Markdown::Grammar:ver<0.3.9>;
use Pod::To::PDF::Lite;
use PDF::Lite;
use PDF::Font::Loader;

# Source Code Pro (Google font) # font used by Tony-o for cro article

my $debug = 0;
my $correction = 0; # flag to turn on my correction for the existing errors
if not @*ARGS.elems {
    print qq:to/HERE/;
    Usage: {$*PROGRAM.basename} go | correct

    Runs the Markdown to PDF pipeline with the current version
      of Markdown::Grammar.

    Use the 'correct' option to use my external fix.
    HERE
    exit
}

for @*ARGS {
    when /^ :i c / { ++$correction }
    when /^ :i d / { ++$debug }
}

# original documents:
my $md1 = "20220224-building-a-cro-app-part-1.md";
my $md2 = "20220923-building-a-cro-app-part-b.md";

# pod from markdown:
my $pod1 = "Creating-a-Cro-App-Part1-by-Tony-O.pod";
my $pod2 = "Creating-a-Cro-App-Part2-by-Tony-O.pod";

# desired output:
my $pdf1 = "Creating-a-Cro-App-Part1-by-Tony-O.pdf";
my $pdf2 = "Creating-a-Cro-App-Part2-by-Tony-O.pdf";

my %md = [
    $md1 => { pod => $pod1, pdf => $pdf1 },
    $md2 => { pod => $pod2, pdf => $pdf2 },
];

for %md.keys -> $md {
    my $pod-fil = %md{$md}<pod>;
    my $pdf-fil = %md{$md}<pdf>;

    # first convert md to pod
    my $text = slurp $md;
    my $pod-str = from-markdown($text, to => 'pod6');
    my @pod-lines = $pod-str.lines;

    if $debug {
        say "line: |$_" for @pod-lines;
        say "DEBUG exit"; exit;
    }

    # correct error in output, issue filed with Markdown::Grammar
    if 0 and $correction {
        shift @pod-lines;
        @pod-lines.unshift: "=begin pod";
    }

    if $debug {
        say "line: |$_" for @pod-lines;
        say "DEBUG exit"; exit;
    }

    # correct another error in output, issue filed with Markdown::Grammar
    #    =begin code raku (```json, ```raku), should be "=begin code :lang<raku>"
    #    =begin code json
    if $correction {
        for 0..^@pod-lines.elems -> $i {
            if @pod-lines[$i] ~~ /\h* '=begin' \h+ code \h+ ':lang<>' \h* $/ {
                @pod-lines[$i] = "=begin code";
            }
        }
    }

    $pod-str = @pod-lines.join("\n");
    spurt $pod-fil, $pod-str;
    say "See output pod file: $pod-fil" if 0;
    #say "DEBUG exit"; exit;


    # extract the pod object from the pod
    my $pod-obj = extract-rakupod-object $pod-str;

    if $debug {
        say $pod-obj.raku;
        say "DEBUG exit"; exit;
    }

    # then convert the pod object to pdf
    #my PDF::Lite $pdf = pod2pdf $pod-obj, :height(), :width(), :margin(), :fonts();
    my PDF::Lite $pdf = pod2pdf $pod-obj, :height(11*72), :width(8.5*72), :margin(1*72);

    $pdf.save-as: $pdf-fil; #"PDF$idx.pdf";
    say "See output pdf file: $pdf-fil";

}

sub extract-rakupod-object(Str:D $pod-string) {
    use MONKEY-SEE-NO-EVAL;
    # from https://github.com/Raku/roast/blob/master/S26-documentation/12-non-breaking-space.t
    my $pod;
    my $code = $pod-string ~ "\n";
    $code ~= "\$pod = \$=pod[0]";
    EVAL $code;
    $pod
}
