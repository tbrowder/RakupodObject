use Test;
use RakupodObject;

my $good-pod-file = "t/data/good.rakudoc";
my $bad-pod-file  = "t/data/bad.rakudoc";

my $good-pod = slurp $good-pod-file;
my $bad-pod  = slurp $bad-pod-file;

my ($good, $bad);

dies-ok {
    $bad = extract-rakupod-object $bad-pod;
}, "bad pod";

dies-ok {
    $bad = extract-rakupod-object $bad-pod-file;
}, "bad pod file";

lives-ok {
    $good = extract-rakupod-object $good-pod;
}, "good pod";

lives-ok {
    $good = extract-rakupod-object $good-pod-file;
}, "good pod file";


done-testing;
