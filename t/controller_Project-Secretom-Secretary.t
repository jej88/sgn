use strict;
use warnings;
use Test::More;

use HTTP::Request::Common;

BEGIN { use_ok 'Catalyst::Test', 'SGN' }
BEGIN { use_ok 'SGN::Controller::Project::Secretom::SecreTary' }

ok( request('/secretom/secretary')->is_success, 'Request should succeed' );

# try a secretary run
my $response = request POST '/secretom/secretary/run', [
    input => <<'',
>AT1G73440.1 AI22=4.545 Gravy22=-1.4545 nR=2 nS=10 nT=0 nDRQPEN=7 Nitrogen=28 Oxygen=42 
MARGESEGESSGSERESSSSSSGNESEPTKGTISKYEKQRLSRIAENKARLDALGISKAAKALLSPSPVSKKRRVKRNSGEEDDDYTPVIADGDGDEDDDEVEEIDEDEEFLCKRKNKSSASKRKVSSRKILNTSVSLGEDDDDLDKAIALSLQGSVAGSDKEAATMKKKRPELMSKTQMTQDELVMYFCQFDEGGKGFITLRDVAKMATVHDFTWTEEELQDMIRCFDMDKDGKLSLDEFRKIVSRCRMLKGS* 
>AT1G75120.1 AI22=119.545 Gravy22=0.5864 nR=2 nS=0 nT=0 nDRQPEN=6 Nitrogen=31 Oxygen=27 
MAVRKEKVQPFRECGIAIAVLVGIFIGCVCTILIPNDFVNFRSSKVASASCESPERVKMFKAEFAIISEKNGELRKQVSDLTEKVRLAEQKEVIKAGPFGTVTGLQTNPTVAPDESANPRLAKLLEKVAVNKEIIVVLANNNVKPMLEVQIASVKRVGIQNYLVVPLDDSLESFCKSNEVAYYKRDPDNAIDVVGKSRRSSDVSGLKFRVLREFLQLGYGVLLSDVDIVFLQNPFGHLYRDSDVESMSDGHDNNTAYGFNDVFDDPTMTRSRTVYTNRIWVFNSGFFYLRPTLPSIELLDRVTDTLSKSGGWDQAVFNQHLFYPSHPGYTGLYASKRVMDVYEFMNSRVLFKTVRKDEEMKKLKPVIIHMNYHSDKLERMQAAVEFYVNGKQDALDRFRDGS* 
>AT1G17600.1 AI22=61.818 Gravy22=-0.2273 nR=2 nS=5 nT=0 nDRQPEN=6 Nitrogen=29 Oxygen=34 
MVSSSAPRVSKYDVFLSFRGEDTRKTIVSHLYAALDSRGIVTFKDDQRLEIGDHISDELHRALGSSSFAVVVLSENYATSRWCLLELQLIMELMKEGRLEVFPIFYGVDPSVVRHQLGSFSLVKYQGLEMVDKVLRWREALNLIANLSGVVSSHCVDEAIMVGEIARDISRRVTLMHKIDSGNIVGMKAHMEGLNHLLDQESNEVLLVGIWGMGGIGKTSIVKCLYDQLSPKFPAHCFIENIKSVSKDNGHDLKHLQKELLSSILCDDIRLWSVEAGCQEIKKRLGNQKVFLVLDGVDKVAQVHALAKEKNWFGPGSRIIITTRDMGLLNTCGVEVVYEVKCLDDKDALQMFKQIAFEGGLPPCEGFDQLSIRASKLAHGLPSAIQAYALFLRGRTASPEEWEEALGALESSLDENIMEILKISYEGLPKPHQNVFLHVVCLFNGDTLQRITSLLHGPIPQSSLWIRVLAEKSLIKISTNGSVIMHKLVEQMGREIIRDDMSLARKFLRDPMEIRVALAFRDGGEQTECMCLHTCDMTCVLSMEASVVGRMHNLKFLKVYKHVDYRESNLQLIPDQPFLPRSLRLFHWDAFPLRALPSGSDPCFLVELNLRHSDLETLWSGTPSNGVKTENPCEKHNSNYFHVLLYLAQMLKSLKRLDVTGSKHLKQLPDLSSITSLEELLLEQCTRLEGIPECIGKRSTLKKLKLSYRGGRRSALRFFLRKSTRQQHIGLEFPDAKVKMDALINISIGGDITFEFRSKFRGYAEYVSFNSEQQIPIISAMSLQQAPWVISECNRFNSLRIMRFSHKENGESFSFDVFPDFPDLKELKLVNLNIRKIPSGICHLDLLEKLDLSGNDFENLPEAMSSLSRLKTLWLQNCFKLQELPKLTQVQTLTLTNCRNLRSLAKLSNTSQDEGRYCLLELCLENCKSVESLSDQLSHFTKLTCLDLSNHDFETLPSSIRDLTSLVTLCLNNCKKLKSVEKLPLSLQFLDAHGCDSLEAGSAEHFEDIPNKEVNTWLLIRLYYD* 
>AT1G51380.1 AI22=84.091 Gravy22=-0.5318 nR=0 nS=0 nT=3 nDRQPEN=7 Nitrogen=26 Oxygen=36 
MEGTLDEENLVFETTKGIKPIKSFDDMGMNDKVLRGVYDYGYKKPSEIQQRALVPILKGRDVIAQAQSGTGKTSMIAISVCQIVNISSRKVQVLVLSPSRELASQTEKTIQAIGAHTNIQAHACIGGKSIGEDIKKLERGVHAVSGTPGRVYDMIKRGSLQTKAVKLLVLDESDEMLSKGLKDQIYDVYRALPHDIQVCLISATLPQEILEMTEKFMTDPVRILVKPDELTLEGIKQYYVDVDKEEWKFDTLCDLYGRLTINQAIIFCNTRQKVDWLTEKMRSSNFIVSSMHGDKRQKERDDIMNQFRSFKSRVLIASDVWARGIDVQTVSHVINYDIPNNPELYIHRIGRAGRFGREGVAINFVKSSDMKDLKDIERHYGTKIREMPADLV* 
>AT1G77370.1 AI22=159.091 Gravy22=1.3318 nR=2 nS=1 nT=0 nDRQPEN=6 Nitrogen=29 Oxygen=28 
MVDQSPRRVVVAALLLFVVLCDLSNSAGAANSVSAFVQNAILSNKIVIFSKSYCPYCLRSKRIFSQLKEEPFVVELDQREDGDQIQYELLEFVGRRTVPQVFVNGKHIGGSDDLGAALESGQLQKLLAAS* 
>AT1G44090.1 AI22=66.364 Gravy22=-0.0773 nR=2 nS=1 nT=2 nDRQPEN=6 Nitrogen=31 Oxygen=28 
MCIYASRQTVCPYLTPFKVKRPKSREMNSSDVNFSLLQSQPNVPAEFFWPEKDVAPSEGDLDLPIIDLSGFLNGNEAETQLAAKAVKKACMAHGTFLVVNHGFKSGLAEKALEISSLFFGLSKDEKLRAYRIPGNISGYTAGHSQRFSSNLPWNETLTLAFKKGPPHVVEDFLTSRLGNHRQEIGQVFQEFCDAMNGLVMDLMELLGISMGLKDRTYYRRFFEDGSGIFRCNYYPPCKQPEKALGVGPHNDPTAITVLLQDDVVGLEVFAAGSWQTVRPRPGALVVNVGDTFMALSNGNYRSCYHRAVVNKEKVRRSLVFFSCPREDKIIVPPPELVEGEEASRKYPDFTWAQLQKFTQSGYRVDNTTLHNFSSWLVSNSDKKST* 

   ];

like( $response->content, qr/2 secreted sequences predicted out of 6/,
      'got correct secreted sequence count' );

like( $response->content, qr/$_/, "ID $_ appears in output" )
    for qw( AT1G73440.1  AT1G75120.1  AT1G17600.1  AT1G51380.1  AT1G77370.1 AT1G44090.1 );

done_testing;
