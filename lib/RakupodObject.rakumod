unit module RakupodObject;

multi sub extract-rakupod-object(IO::Path:D $pod-file) is export { 
    my Str $pod-string = slurp $pod-file;
    extract-rakupod-object $pod-string
}

multi sub extract-rakupod-object(Str:D $pod-string) is export {
    use MONKEY-SEE-NO-EVAL;
    # from https://github.com/Raku/roast/blob/master/S26-documentation/12-non-breaking-space.t
    my $pod;
    my $code = $pod-string ~ "\n";
    $code ~= "\$pod = \$=pod[0]";
    EVAL $code;
    $pod
}

