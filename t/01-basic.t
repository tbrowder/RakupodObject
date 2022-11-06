use Test;
use RakupodObject;

my $good-pod-file = "t/data/good.rakudoc".IO;
my $bad-pod-file  = "t/data/bad.rakudoc".IO;
my $raku-file     = "t/data/raku.raku".IO;

my $good-pod = slurp $good-pod-file;
my $bad-pod  = slurp $bad-pod-file;
my $raku-pod = slurp $raku-file;

my ($good, $bad);

dies-ok {
    $bad = extract-rakupod-object $bad-pod;
}, "bad pod string";

dies-ok {
    $bad = extract-rakupod-object $bad-pod-file;
}, "bad pod file";

lives-ok {
    $good = extract-rakupod-object $good-pod;
}, "good pod string";
isa-ok $good, Pod::Block::Named;
cmp-ok $good, '~~', Pod::Block, "is a Pod::Block";

lives-ok {
    $good = extract-rakupod-object $good-pod-file;
}, "good pod file";
isa-ok $good, Pod::Block::Named;
cmp-ok $good, '~~', Pod::Block, "is a Pod::Block";

lives-ok {
    $good = extract-rakupod-object $raku-pod;
}, "good raku file with pod";
isa-ok $good, Pod::Block::Comment;
cmp-ok $good, '~~', Pod::Block, "is a Pod::Block";

done-testing;
