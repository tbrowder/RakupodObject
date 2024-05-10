unit module RakupodObject;

sub extract-rakupod-object(
    $pod-src is copy
    --> Pod::Block
) is export {
    if $pod-src.IO.r {
        $pod-src = slurp $pod-src.IO;
    }

    use MONKEY-SEE-NO-EVAL;
    # from https://github.com/Raku/roast/blob/master/
    #              S26-documentation/12-non-breaking-space.t
    my $pod;
    my $code = $pod-src ~ "\n";
    $code ~= "\$pod = \$=pod[0]";
    EVAL $code;
    $pod
}
