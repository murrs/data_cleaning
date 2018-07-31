library(haven)
library(data.table)

#Read in Data
censusRaw = read_dta("C:\\Users\\Aaron\\Documents\\census\\Data\\main_results_2017\\Random sampling\\Stata\\Census2017RawData2.dta")

#Convert to data.table for efficiency
censusRaw = as.data.table(censusRaw)

#Rename Variables
setnames(censusRaw, 
         old = c("response_id",
                 "time_started",
                 "date_submitted",
                 "status",
                 "variabl0",
                 "variabl00",
                 "variabl01",
                 "what_year_were_you_born_",
                 "what_is_your_current_gender_",
                 sapply(2:9, function(n){paste0("variabl0", n)}),
                 sapply(0:99, function(n){
                   if(n < 10){paste0("variabl00", n)}
                   else{paste0("variabl0", n)}
                 }),
                 sapply(0:39, function(n){
                   if(n < 10){paste0("variabl000", n)}
                   else{paste0("variabl00", n)}
                 }),
                 sapply(41:99, function(n){
                   if(n < 10){paste0("variabl000", n)}
                   else{paste0("variabl00", n)}
                 }),
                 "do_you_identify_as_a_burner_",
                 sapply(100:305, function(n){paste0("variabl0", n)}),
                 "how_long_did_that_change_last_",
                 sapply(306:355, function(n){paste0("variabl0", n)})),
         new = c("id",
                 "startdate",
                 "enddate",
                 "completed",
                 "consent",
                 "firstfill",
                 "firstyear",
                 "birth",
                 "gender",
                 "sex",
                 "nbburns_1",
                 "nbburns_2",
                 "nbburns_3",
                 "nbburns_4",
                 "nbburns_5",
                 "nbburns_6",
                 "nbburns_7",
                 "nbburns_8",
                 "nbburns_9",
                 "nbburns_10",
                 "nbburns_11",
                 "nbburns_12",
                 "nbburns_13",
                 "nbburns_14",
                 "nbburns_15",
                 "nbburns_16",
                 "nbburns_17",
                 "nbburns_18",
                 "nbburns_19",
                 "nbburns_20",
                 "nbburns_21",
                 "nbburns_22",
                 "nbburns_23",
                 "nbburns_24",
                 "nbburns_25",
                 "nbburns_26",
                 "nbburns_27",
                 "nbburns_28",
                 "nbburns_29",
                 "nbburns_30",
                 "nbburns_31",
                 "nbburns_32",
                 "nbburns_33",
                 "residence",
                 "residenceother",
                 "zipcode",
                 "postalcode",
                 "incomep",
                 "household",
                 "incomeh",
                 "educ_1",
                 "educ_2",
                 "educ_3",
                 "educ_4",
                 "educ_5",
                 "techvocational_certif",
                 "educother",
                 "educ_6",
                 "educother_qual",
                 "language",
                 "language_TEXT",
                 "asian",
                 "native",
                 "hispanic",
                 "white",
                 "middleeastern",
                 "black",
                 "ethnoother",
                 "native_qual",
                 "ethnoother_qual",
                 "color",
                 "usvote",
                 "vote2016",
                 "vote2014",
                 "vote2012",
                 "vote2010",
                 "votenone",
                 "usparty",
                 "uspartyother",
                 "politicalid",
                 "politicalid_qual",
                 "sexattraction",
                 "sexorientation",
                 "trans",
                 "genderqueer",
                 "gendernonconforming",
                 "genderquestioning",
                 "twospirit",
                 "intersex",
                 "married",
                 "openrelat",
                 "mono",
                 "poly",
                 "kink",
                 "swinger",
                 "queer",
                 "loveaddict",
                 "open_curious",
                 "othersexlabel",
                 "othersexlabel_qual",
                 "spirituality",
                 "religion",
                 "religionotherChr",
                 "religionother",
                 "bmevents",
                 "bminvolve_prod",
                 "bminvolve_art",
                 "bminvolve_camp",
                 "bminvolve_vendor",
                 "bminvolve_perfo",
                 "bminvolve_other",
                 "bminvolve_not",
                 "bminvolve_other_qual",
                 "bminfojrs",
                 "bminfodl",
                 "bminfobmweb",
                 "bminfobmjournal",
                 "bminforegnew",
                 "bminforegweb",
                 "bminfobmir",
                 "bminfosmbm",
                 "bminfosmnot",
                 "bminfoeplaya",
                 "bminfowom",
                 "bminfoother_TEXT",
                 "valued_brcevents",
                 "valued_sfevents",
                 "valued_worldevents",
                 "valued_regevents",
                 "valued_volunteer",
                 "valued_brcprep",
                 "valued_pics",
                 "valued_stories",
                 "valued_nonprofit",
                 "valued_other",
                 "valued_other_qual",
                 "bmir_online",
                 "bmir_travelmobile",
                 "bmir_brcair",
                 "bmir_centercamp",
                 "bmir_didntknow",
                 "bmir_no",
                 "bmgr",
                 "bmprogramsbwb",
                 "bmprogramsbma",
                 "bmprogramsbrs",
                 "bmprogramsbmrn",
                 "princf_incl",
                 "princf_gift",
                 "princf_decom",
                 "princf_reli",
                 "princf_expr",
                 "princf_commu",
                 "princf_resp",
                 "princf_lnt",
                 "princf_part",
                 "princf_immed",
                 "princf_incl_qual",
                 "princf_gift_qual",
                 "princf_decom_qual",
                 "princf_reli_qual",
                 "princf_expr_qual",
                 "princf_commu_qua",
                 "princf_resp_qual",
                 "princf_lnt_qual",
                 "princf_part_qual",
                 "princf_immed_qua",
                 "princd_incl",
                 "princd_gift",
                 "princd_decom",
                 "princd_reli",
                 "princd_expr",
                 "princd_commu",
                 "princd_resp",
                 "princd_lnt",
                 "princd_part",
                 "princd_immed",
                 "prinimport",
                 "prinessent",
                 "princchange",
                 "princwork",
                 "volunteerbrc",
                 "volunteerbmreg",
                 "volunteerbwb",
                 "volunteerart",
                 "volunteerpolit",
                 "volunteerschool",
                 "volunteerenv",
                 "volunteercommun",
                 "volunteerself",
                 "volunteerother",
                 "volunteerother_q",
                 "volunteerinspire",
                 "skillcreation",
                 "skillperf",
                 "skilllead",
                 "skillmanag",
                 "skillconstruct",
                 "skillcarpmetal",
                 "skillgraph",
                 "skillmedit",
                 "skillemotion",
                 "skillother",
                 "skillother_qual",
                 "skilluseful",
                 "skillusefam",
                 "skillusecomm",
                 "skilluseteach",
                 "skillusebrc",
                 "certifosha",
                 "certifhippa",
                 "certifcpr",
                 "certiffoodsafety",
                 "certifmachinery",
                 "certiffiresafety",
                 "certifother_qual",
                 "burnerid",
                 "yearround",
                 "don_artus",
                 "don_artabroad",
                 "don_commun",
                 "don_brcplan",
                 "don_lowincome",
                 "don_artplaya",
                 "don_regional",
                 "don_other",
                 "arrival",
                 "leaving",
                 "travelbrc",
                 "travelbrcother",
                 "fly",
                 "flyother",
                 "nbvehicle",
                 "nb012vehicle",
                 "nb1317vehicle",
                 "vehicletype",
                 "vehicletypeother",
                 "milestotal",
                 "milesnev",
                 "mpg",
                 "mpgother",
                 "bxb_sftobrc",
                 "bxb_renotobrc",
                 "bxb_brctosf",
                 "bxb_brctoreno",
                 "bxbcamp",
                 "bxbshuttle",
                 "bxbforcost",
                 "bxbfornodriving",
                 "bxbforgatetraffi",
                 "bxbforroadconges",
                 "bxbforasbefore",
                 "bxbforother",
                 "bxbforother_qual",
                 "bxbprice",
                 "bxbticketexp",
                 "bxbexp",
                 "bxbreccommendati",
                 "ticketwhere",
                 "ticketwhere_qual",
                 "ticketcost",
                 "ticketcost_qual",
                 "bmspending",
                 "nvspendfuel",
                 "nvspendfood",
                 "nvspendlodging",
                 "nvspendsurvival",
                 "nvspendfun",
                 "parkvisit",
                 "sortwaste",
                 "sortburnable",
                 "sortrecyc",
                 "sortcompost",
                 "sortother",
                 "sortother_qual",
                 "trashcampserv",
                 "trashggid",
                 "trashexodusprg",
                 "trashtransfersta",
                 "trashdumpster",
                 "trashfriend",
                 "trashonmyway",
                 "trashdropped",
                 "trashhome",
                 "trashbxb",
                 "trashsomeone",
                 "trashother",
                 "trashother_qual",
                 "nbcamp",
                 "rv",
                 "rvadults",
                 "nbfamily",
                 "broughtminor",
                 "childban",
                 "powerno",
                 "powerbat",
                 "powersol",
                 "powerwind",
                 "powervehic",
                 "powercamp",
                 "poweranot",
                 "powergrid",
                 "powerother",
                 "powerother_qual",
                 "vehicfueltype",
                 "vehicfueltypeoth",
                 "hoursvehicgen",
                 "campfueltype",
                 "campfueltypeothe",
                 "campgenoutput",
                 "hourscampgen",
                 "address_letter",
                 "address_hour",
                 "assignedcamp",
                 "locationattract",
                 "locationsurface",
                 "locationfriend",
                 "locationavailabl",
                 "locationneighbor",
                 "locationsamelast",
                 "locationdifflast",
                 "locationquiet",
                 "locationparties",
                 "locationidk",
                 "desirereli",
                 "attainreli",
                 "desireadv",
                 "attainadv",
                 "desiresocresp",
                 "attainsocresp",
                 "desireties",
                 "attainties",
                 "desireaccept",
                 "attainaccept",
                 "desirespc" ,
                 "attainspc",
                 "desireesth",
                 "attainesth",
                 "desireanx",
                 "attainanx",
                 'desireqol',
                 "attainqol",
                 "desirefree",
                 "attainfree",
                 "desirevalues",
                 "attainvalues",
                 "desireart",
                 "attainart",
                 "desireexpres",
                 "attainexpres",
                 "desirespi" ,
                 "attainspi",
                 "desirecoop",
                 "attaincoop",
                 "desirerecyc",
                 "attainrecyc",
                 "desirestew",
                 "attainstew",
                 "desireprotec",
                 "attainprotec",
                 "desireimpact",
                 "attainimpact",
                 "desirecommaesthe",
                 "attaincommaesthe",
                 "desireecotour",
                 "attainecotour",
                 "contribthink",
                 "contribgroup",
                 "contribnat",
                 "contribremote",
                 "contribdesert",
                 "contribfacilitie",
                 "contribactivitie",
                 "contribart",
                 "contribmeet",
                 "publiccamping",
                 "publichiking",
                 "publicswiming",
                 "publicspring",
                 "publicsailing",
                 "publicbm",
                 "publicother",
                 "publicother_qual",
                 "nevadacities",
                 "intendbrd",
                 "smilebrcfriend",
                 "smiledwfriend",
                 "smilebrccontrol",
                 "smiledwcontrol",
                 "smilebrchappy",
                 "smiledwhappy",
                 "emotionbrc",
                 "emotiondw",
                 "statusbrc",
                 "statusdw",
                 "artist",
                 "brcsafe",
                 "brcconnect",
                 "burnerfamily",
                 "money",
                 "toexpart",
                 "towork",
                 "tomeetlike",
                 "tomeetdiff",
                 "toplay",
                 "toconsume",
                 "toescape",
                 "toselfexpress",
                 "toexpgifting",
                 "toselfrely",
                 "toperform",
                 "tosatiscuriosity",
                 "togrow",
                 "tosatissomeone",
                 "toother",
                 "toother_qual",
                 "enjoy",
                 "intend",
                 "transfo",
                 "transfoextent",
                 "transfoexp",
                 "transfodesire",
                 "transfoper",
                 "longchange",
                 "specexp",
                 "specmoral",
                 "specexpect",
                 "specdesire",
                 "specglad",
                 "bestintentions",
                 "selfother",
                 "givetostranger",
                 "playdw",
                 "newfriendsdw",
                 "notgonecost",
                 "notgonenoticket",
                 "notgonetoofar",
                 "notgoneweather",
                 "notgonecamping",
                 "notgonewhite",
                 "notgonehomo",
                 "notgoneintox",
                 "notgonehippies",
                 "notgonenaked",
                 "notgoneelectro",
                 "notgonemen",
                 "notgoneunsafe",
                 "notgonevalues",
                 "notgoneother",
                 "notgoneother_qua",
                 "notgonenoticketn",
                 "notgonetoofarnb",
                 "notgoneweathernb",
                 "notgonecampingnb",
                 "notgonewhitenb",
                 "notgonehomonb",
                 "notgoneintoxnb",
                 "notgonehippiesnb",
                 "notgonenakednb",
                 "notgoneelectronb",
                 "notgonemennb",
                 "notgoneunsafenb",
                 "notgonevaluesnb",
                 "notgoneothernb",
                 "notgonecostnb",
                 "sampledgate",
                 "sampledairport",
                 "sampledbxb",
                 "fieldnotes",
                 "visitedcensus",
                 "onlinecensus",
                 "voluntonplaya",
                 "voluntoffplaya",
                 "censusposts"))

# 
# destring consent- residence incomep- educ_6 language asian- ethnoother color- usparty politicalid sexattraction- othersexlabel spirituality- religion bmevents- bminvolve_not bminfojrs- bminfowom valued_brcevents- valued_other bmir_online- bmprogramsbmrn princd_incl- volunteerother volunteerinspired- skillother skilluseful- certiffiresafety burnerid- yearround arrival -travelbrc fly nbvehicle- vehicletype mpg bxb_sftobrc- bxbforother bxbprice- bxbexp ticketwhere ticketcost parkvisit- sortother trashcampserv- trashother nbcamp- powerother vehicfueltype hoursvehicgen- campfueltype campgenoutput- assignedcamp locationattract- locationidk desirereli-publicother intendbrd-statusdw artist- burnerfamily toexpart- toother enjoy- notgoneother notgonenoticketnb- notgonecostnb sampledgate- censusposts, replace force
# 
# *Drop useless variables and cases, IPaddress, 
# tab firstfill,m
# destring consent, replace force
# keep if consent==3
# drop consent
# *keep if firstfill==1
# *drop firstfill
# 
# *Cleaning gender & sex
# tab1 gender,m
# codebook gender
# recode gender (2=0)(3=2)
# label define gender 0 "male" 1 "female" 2 "fluid"
# lab val gender gender
# 
# tab1 sex,m
# recode sex (2=0)
# replace gender=sex if gender==. & sex<1.5
# replace sex=gender if sex==. & gender<1.5
# label define sex 0"male" 1"female" 
# lab val sex sex
# 
# *Cleaning firstyear
# label define firstyear 1"yes" 2"no" 3"did_not_go_this_year"
# label val firstyear firstyear
# recode firstyear (1=1) (2=0) (3=.), gen(virgin)
# label define yn 0"no" 1 "yes"
# lab value virgin yn
# tab1 virgin,m
# 
# *Gender and relational labels
# recode trans-intersex mono-othersexlabel (1/9=1)(.=0)
# lab val trans-intersex mono-othersexlabel yn
# tab1 trans-intersex mono-othersexlabel
# gen polykink=poly
# replace polykink=2 if poly==0 & kink==1
# replace polykink=3 if poly==1 & kink==1
# lab def pk 0"No" 1"Poly" 2"Kinkster" 3"PolyKinkster"
# lab value polykink pk
# tab1 polykink,m
# 
# *Clean age 
# tab birth,m
# gen age=2017-birth
# recode age (0/12=0) (13/19=1) (20/24=2) (25/29=3) (30/34=4) (35/39=5) (40/49=6) (50/59=7) (60/69=8) (70/79=9) (80/89=10) (90/99=11) (100/119=12), gen(agegr)
# lab def ag 0"_0_12" 1"_13_19" 2"_20_24" 3"_25_29" 4"_30_34" 5"_35_39" 6"_40_49" 7"_50_59" 8"_60_69" 9"_70_79" 10"_80_89" 11"_90_99" 12"_100_or_more"
# lab value agegr ag
# tab1 age agegr
# recode age (0/19=0) (20/40=1) (41/119=2), gen(agegr2)
# lab def ag2 0"_0_19" 1"_20_40" 2"_41_or_more"
# lab value agegr2 ag2
# gen agegr3=agegr
# recode agegr3 (0=1) (10/12=9)
# lab def ag3 1"_0_19" 2"_20_24" 3"_25_29" 4"_30_34" 5"_35_39" 6"_40_49" 7"_50_59" 8"_60_69" 9"_70_or_more"
# lab value agegr3 ag3
# gen agegr4=agegr3
# recode agegr4 (3=2) (4 5=3)(6=4)(7 8 9=5)
# lab def ag4 1"_0_19" 2"_20_29" 3"_30_39" 4"_40_49" 5"_50_or_more" 
# lab value agegr4 ag4
# gen agegr5=agegr4
# recode agegr5 (5=4)
# lab def ag5 1"_0_19" 2"_20_29" 3"_30_39" 4"_40_or_more" 
# lab value agegr5 ag5
# 
# *Create previousburns & timesincefirstburn
# recode nbburns* (1/9999999=1)
# egen nbburns=anycount(nbburns_2- nbburns_33), v(1) 
# tab nbburns virgin,m
# drop if virgin==0 & nbburns==0
# drop if virgin==1 & nbburns>=1
# recode virgin (.=1) if nbburns==0 & nbburns_1==1
# recode virgin (.=0) if nbburns>0 
# recode nbburns (0=0)(1=1)(2=2)(3/4=3)(5/7=4)(8/10=5)(11/32=6), gen(nbburns2)
# lab def nbburns2 0"virgin" 1"_1" 2"_2" 3"_3to4" 4"_5to7" 5"_8to10" 6"_11or_more"
# lab val nbburns2 nbburns2
# recode nbburns2 (6=5), gen(nbburns3)
# lab def nbburns3 0"virgin" 1"_1" 2"_2" 3"_3to4" 4"_5to7" 5"_8_or_more"
# lab val nbburns3 nbburns3
# 
# recode nbburns3 (2=1)(3/4=2)(5=4), gen(nbburns4)
# lab def nbburns4 0"virgin" 1"_1to2" 2"_3to7" 3"_8_or_more"
# lab val nbburns4 nbburns4
# recode nbburns3 (2/3=1)(4/5=2), gen(nbburns5)
# lab def nbburns5 0"virgin" 1"_1to4" 2"_5_or_more"
# lab val nbburns5 nbburns5
# 
# gen timesincefirstburn=.
# replace timesincefirstburn=0 if virgin==1
# replace timesincefirstburn=1 if nbburns_2==1
# replace timesincefirstburn=2 if nbburns_3==1
# replace timesincefirstburn=3 if nbburns_4==1
# replace timesincefirstburn=4 if nbburns_5==1
# replace timesincefirstburn=5 if nbburns_6==1
# replace timesincefirstburn=6 if nbburns_7==1
# replace timesincefirstburn=7 if nbburns_8==1
# replace timesincefirstburn=8 if nbburns_9==1
# replace timesincefirstburn=9 if nbburns_10==1
# replace timesincefirstburn=10 if nbburns_11==1
# replace timesincefirstburn=11 if nbburns_12==1
# replace timesincefirstburn=12 if nbburns_13==1
# replace timesincefirstburn=13 if nbburns_14==1
# replace timesincefirstburn=14 if nbburns_15==1
# replace timesincefirstburn=15 if nbburns_16==1
# replace timesincefirstburn=16 if nbburns_17==1
# replace timesincefirstburn=17 if nbburns_18==1
# replace timesincefirstburn=18 if nbburns_19==1
# replace timesincefirstburn=19 if nbburns_20==1
# replace timesincefirstburn=20 if nbburns_21==1
# replace timesincefirstburn=21 if nbburns_22==1
# replace timesincefirstburn=22 if nbburns_23==1
# replace timesincefirstburn=23 if nbburns_24==1
# replace timesincefirstburn=24 if nbburns_25==1
# replace timesincefirstburn=25 if nbburns_26==1
# replace timesincefirstburn=26 if nbburns_27==1
# replace timesincefirstburn=27 if nbburns_28==1
# replace timesincefirstburn=27 if nbburns_29==1
# replace timesincefirstburn=28 if nbburns_30==1
# replace timesincefirstburn=29 if nbburns_31==1
# replace timesincefirstburn=30 if nbburns_32==1
# replace timesincefirstburn=31 if nbburns_33==1
# tab1 timesincefirstburn,m
# *drop nbburns_1- nbburns_33
# recode timesincefirstburn (0=0)(1/2=1)(3/4=2)(5/7=3)(8/11=4)(12/15=5)(16/32=6), gen(timesincefirstburn2)
# lab def timesincefirstburn2 0"virgin" 1"_1or2years" 2"_3or4years" 3"_5to7years" 4"_8to11years" 5"_12to15years" 6"_16or_more"
# lab val timesincefirstburn2 timesincefirstburn2
# drop nbburns_1 
# rename nbburns_2 burn2016
# rename nbburns_3 burn2015
# rename nbburns_4 burn2014
# rename nbburns_5 burn2013
# rename nbburns_6 burn2012
# rename nbburns_7 burn2011
# rename nbburns_8 burn2010
# rename nbburns_9 burn2009
# rename nbburns_10 burn2008
# rename nbburns_11 burn2007
# rename nbburns_12 burn2006
# rename nbburns_13 burn2005
# rename nbburns_14 burn2004
# rename nbburns_15 burn2003
# rename nbburns_16 burn2002
# rename nbburns_17 burn2001
# rename nbburns_18 burn2000
# rename nbburns_19 burn1999
# rename nbburns_20 burn1998
# rename nbburns_21 burn1997
# rename nbburns_22 burn1996
# rename nbburns_23 burn1995
# rename nbburns_24 burn1994
# rename nbburns_25 burn1993
# rename nbburns_26 burn1992
# rename nbburns_27 burn1991
# rename nbburns_28 burn1990brd
# rename nbburns_29 burn1990baker
# rename nbburns_30 burn1989
# rename nbburns_31 burn1988
# rename nbburns_32 burn1987
# rename nbburns_33 burn1986
# 
# *Residence
# tab residence,m
# lab def reside 1"Nevada" 2"California" 3"USA_other" 4"Canada" 5"Other"
# lab val residence reside
# 
# *Note to self:  This is hunter manually poring through data to recode messy values to something not messy
# *NOT FINISHED Cleaning residenceother ()
# replace residenceother="usa" if residence==1 |residence==2 |residence==3 
# replace residenceother="canada" if residence==4
# replace residenceother="." if strmatch(residenceother,"")
# replace residenceother = subinstr(residenceother,"."," ",3)
# replace residenceother = subinstr(residenceother,","," ",3)
# replace residenceother = subinstr(residenceother,"("," ",3)
# replace residenceother = subinstr(residenceother,")"," ",3)
# replace residenceother = subinstr(residenceother,"/"," ",3)
# replace residenceother = subinstr(residenceother,"  "," ",3)
# replace residenceother=lower(residenceother)
# replace residenceother=regexr(residenceother,"^.*(59802|boston|district of|fort lauder|maryland|michig|missour|pennsylv|the last three years in nv).*$","usa")
# replace residenceother=regexr(residenceother,"^.*(saut a cruz|crook|el dorado|denver|hawaii|sonoma|marin|napa|santa clara|santa cruz|san diego|sacramento|portland|san fran|s f sf|berkeley|palo alto|los angeles|washoe|kern).*$","usa")
# replace residenceother=regexr(residenceother,"^.*(arizon|wy|wa|utah|seattle|alask|arkans|arlington|colorado|florid|forid|hawai|kansas|illinois|new jersey|new york|nyc|oregon|ohio|texas|merica|murrica|murika|usa|1|austin tx|az|brooklyn ny|chicago|indiana|massachusetts|minnesota|montana).*$","usa")
# replace residenceother=regexr(residenceother,"^.*(north carolina|ny|okhlahoma|oklahoma|philadelphia|tennessee|united states|us virgin|06830).*$","usa")
# replace residenceother ="usa" if residenceother=="us" | residenceother=="ca" | residenceother=="ma" | residenceother=="mi" | residenceother=="main" |residenceother=="la"|residenceother=="sf"|residenceother=="s.f.sf, ca"
# replace residenceother ="usa" if residenceother=="urban actually" | residenceother=="kern" | residenceother=="clark" | residenceother=="kings" | residenceother=="king" | residenceother=="moontribe"
# replace residenceother=regexr(residenceother,"^.*(wngland|united-kin|united kin|unite kingdom|great britain|gb|guerns|england|scotland|london|irelan|u k).*$","uk")
# replace residenceother=regexr(residenceother,"^.*(china|hong kong|singapore).*$","china")
# replace residenceother=regexr(residenceother,"^.*(canada|cananda|canda|humboldt|vancouver|québec|alberca).*$","canada")
# replace residenceother=regexr(residenceother,"^.*(straya|austral|tralia|sydney|melbourn).*$","australia")
# replace residenceother ="australia" if residenceother=="aus" 
# replace residenceother=regexr(residenceother,"^.*(guat).*$","guatemala")
# replace residenceother=regexr(residenceother,"^.*(neth|holland|amster|nl).*$","netherlands")
# replace residenceother=regexr(residenceother,"^.*(arab|uae|u a e|dubai).*$","united arab emirates")
# replace residenceother=regexr(residenceother,"^.*(isr).*$","israel")
# replace residenceother=regexr(residenceother,"^.*(jap|jpn).*$","japan")
# replace residenceother=regexr(residenceother,"^.*(ger).*$","germany")
# replace residenceother=regexr(residenceother,"^.*(kor).*$","korea")
# replace residenceother=regexr(residenceother,"^.*(french|frnace|france|fance).*$","france")
# replace residenceother=regexr(residenceother,"^.*(denm).*$","denmark")
# replace residenceother=regexr(residenceother,"^.*(braz|brasil).*$","brazil")
# replace residenceother ="brazil" if residenceother=="br" 
# replace residenceother=regexr(residenceother,"^.*(ital).*$","italy")
# replace residenceother=regexr(residenceother,"^.*(moscow).*$","russia")
# replace residenceother=regexr(residenceother,"^.*(wien).*$","austria")
# replace residenceother=regexr(residenceother,"^.*(geneva|swiss|switz|switer|zurich).*$","switzerland")
# replace residenceother=regexr(residenceother,"^.*(south afri|suth afri|souh afri).*$","south africa")
# replace residenceother=regexr(residenceother,"^.*(uk).*$","uk") if residenceother!="ukraine"
# replace residenceother=regexr(residenceother,"^.*(all over|earth|one world|travel|roam|nomad|on the road|citizen of the world|somewhere|no address|transient|wherever we are).*$","world")
# replace residenceother = proper(residenceother)
# tab residenceother,m
# *Create simplified country var
# gen country =9 
# tostring country, replace
# replace country ="." if residenceother=="." | residenceother==" " |residenceother=="World"|residenceother=="Yo Mama" |residenceother=="B"
# replace country ="0" if residenceother=="Usa" 
# replace country ="1" if residenceother=="Canada" 
# replace country ="2" if residenceother=="Uk"
# replace country ="3" if residenceother=="Australia" | residenceother=="Austialia" | residenceother=="New Zealand" | residenceother=="Auckland New Zealand"
# replace country="3" if regexm(residenceother,"^.*(Papua|New Zeal).*$")==1
# replace country="4" if regexm(residenceother,"^.*(Canary|Slovakia|Monaco|Moldov|Lithuan|Cyprus|Croatia|Eu|Portug|Athens|Greece|Europe|Belg|Denm|Swed|Finl|Fran|Germ|Nether|Latvi|Polan|Spain|Switz|Ukrai|Hung|Ital|Austria|Norw|Roma|Russ|Serb|Cze|Eston|Luxem).*$")==1
# replace country="5" if regexm(residenceother,"^.*(Virgin Island|MéXico|St Maarten|Trinidad|Panam|Nicaragua|Grenada|Dominican Republic|Belize|Ecuador|Boliv|Braz|Costa|Peru|Guate|Mex|Urugu|Argent|Bermuda|Chile|Colomb|Puerto|Venez|Cayman).*$")==1
# replace country="6" if regexm(residenceother,"^.*(Turkey|Istanb|Indones|Pakis|Chin|Indi|Jap|Thai|Taiw|Philipp|Kore|Viet|Asia|Bali Indonesia|Burma|Cambodia).*$")==1
# replace country="7" if regexm(residenceother,"^.*(Tanzania|Tunisia|Morocco|Africa|Isra|Kuwa|South Africa|United Arab|Swazil|Palest|Leban|Qatar|Ghana|Angola).*$")==1
# destring country, replace
# replace country=0 if residence==1 | residence==2 | residence==3
# replace country=1 if residence==4
# lab def countries 0"USA" 1"Canada" 2"UK_Ireland" 3"Oceania" 4"Europe" 5"SouthofUSA" 6"Asia" 7"Africa" 9"To_be_classified"
# lab value country countries
# *Create foreignipf
# recode country (0=0) (1/7=1) (9=0) (.=0), gen(foreignipf)
# tab country if country!=0
# *TO SEE WHAT HAS TO BE RECODED (33 left to recode)
# tab residenceother if country==9,m
# 
# 
# *Cleaning zip (excludes non-us codes)
# replace zipcode = subinstr(zipcode," ","",6)
# replace zipcode = regexs(1) if regexm(zipcode, "[ a-zA-Z]*([0-9][0-9][0-9][0-9][0-9])[\-]*[0-9]*[ a-zA-Z]*")
# destring zipcode, replace force
# *Cleaning postal code (still some numbers)
# replace postalcode=upper(postalcode)
# replace postalcode = subinstr(postalcode," ","",6)
# replace postalcode = regexs(1) if regexm(postalcode, "^([A-Z][0-9][A-Z])[\-]*[0-9]*[A-Z]*[0-9]*")
# 
# *Cleaning income
# recode household (2=0)
# lab val household yn
# recode incomeh (11=0)
# replace incomeh=incomeh+1
# replace incomeh=incomep if incomeh==. & household==0
# replace incomeh=. if incomeh<incomep
# lab def inc 1"None" 2"Less_than_7500US" 3"_7500_14999US" 4"_15000_24999US" 5"_25000_34999US" 6"_35000_49999US" 7"_50000_74999US" 8"_75000_99999US" 9"_100k_149999US" 10"_150k_299999US" 11"_300kUS_or_more"
# lab value incomep incomeh inc
# recode incomep (1 2 3 4=1)(5 6=2)(7 8=3)(9 10=4)(11=5), gen(incomep2)
# recode incomeh (1 2 3 4=1)(5 6=2)(7 8=3)(9 10=4)(11=5), gen(incomeh2)
# lab def inc2 1"Less_than_25000US" 2"_25000_49999US" 3"_50000_99999US" 4"_100k_299999US" 5"_300kUS_or_more"
# lab value incomep2 incomeh2 inc2
# 
# tab1 income*,m
# 
# *Clean educ (EDUCOTHER NOT CLEANED)
# recode educ_* techvocational_certif educother (1/10=1)
# gen educ=.
# replace educ=0 if educ_6==1
# replace educ=6 if techvocational_certif==1
# replace educ=6 if educother==1
# replace educ=1 if educ_1==1
# replace educ=2 if educ_2==1
# replace educ=3 if educ_3==1
# replace educ=4 if educ_4==1
# replace educ=5 if educ_5==1
# replace educ=. if educ>=1 & educ<=5 & educ_6==1 
# label def educ 0"None" 1"High_school" 2"Some_college" 3"Assoc_degree" 4"Bac_degree" 5"Grad_degree" 6"Only_other"
# label val educ educ
# label val techvocational_certif yn
# recode techvocational_certif (.=0) if educ!=.
# tab educ
# 
# *Clean language
# label def lang 1"English" 2"Arabic" 3"Chinese" 4"Danish" 5"Dutch" 6"Farsi" 7"French" 8"German" 9"Hebrew" 10"Hindi" 11"Italian" 12"Japanese" 13"Norwegian" 14"Polish" 15"Portuguese" 16"Punjabi" 17"Romanian" 18"Russian" 19"Spanish" 20"Swedish" 21"Tagalog" 22"Urdu" 23"Other"
# label val language lang
# tab language,m
# 
# *RECODING LANGUAGEOTHER WOULD IMPROVE
# *Create english & englishipf
# recode language (1=1)(2/23=0)(.=.) , gen(english)
# gen englishipf=english
# recode englishipf (.=1)
# lab value english yn
# lab value englishipf yn
# tab1 english* if educ!=.
# 
# *Clean ethno (other and multiple TO BE RECODED)
# recode asian-ethnoother (1/10=1)
# egen ethnocount=anycount(asian-ethnoother), v(1)
# tab ethnocount 
# gen ethno=.
# replace ethno=0 if ethnocount==1 & white==1
# replace ethno=1 if ethnocount==1 & asian==1
# replace ethno=2 if ethnocount==1 & hispanic==1
# replace ethno=3 if ethnocount==1 & black==1
# replace ethno=4 if ethnocount==1 & native==1
# replace ethno=5 if ethnocount==1 & middleeastern==1
# replace ethno=6 if ethnocount==1 & ethnoother==1
# replace ethno=6 if ethnocount>1 
# recode asian-ethnoother (.=0) if ethno!=.
# label def ethno 0"white" 1"asian" 2"hispanic" 3"black" 4"native" 5"middleeastern" 6"other_or_mix"
# label val ethno ethno
# label val asian yn
# label val native yn
# label val white yn
# label val black yn
# label val hispanic yn
# label val middleeastern yn
# label val ethnoother yn
# tab ethno
# 
# *Clean color
# recode color (2=1)(3=2)(1=3)
# lab def nsy 1"No" 2"Sometimes" 3"Yes"
# lab value color nsy
# tab1 color
# 
# *Clean usvote
# recode usvote (1=1)(2=0)
# label val usvote yn
# 
# *Clean federal vote
# recode vote2016-vote2010 votenone (1/99=1)
# egen nbvotes=anycount(vote2016-vote2010), v(1) 
# replace nbvotes=. if usvote==0 | usvote==.
# replace nbvotes=. if votenone==1 & nbvotes>=1
# replace nbvotes=. if votenone==. & nbvotes==0
# *Create votestatus
# recode nbvotes (2/5=1), gen(voteyn)
# lab value voteyn yn
# tab nbvotes voteyn,m
# drop vote2016-votenone
# gen votestatus=usvote
# replace votestatus=2 if usvote==1 & nbvotes>0
# label def vstat 0"not_eligib" 1"didnt_vote" 2"voted"
# label val votestatus vstat
# 
# *POLITICS
# *Clean usparty
# replace usparty=. if usvote!=1
# recode usparty (6=5)(7=6)
# lab def usparty 1"Democratic" 2"Republican" 3"Libertarian" 4"Green" 5"Other" 6"None" 
# lab val usparty usparty
# *POSSIBLE RECODING WITH USPARTYOTHER
# replace uspartyother="" if usvote!=1
# *Generate uspartyipf for weights (for the weights, multiple affiliation was considered as independent)
# gen uspartyipf=usparty
# recode uspartyipf (.=0) if usvote==0
# lab def party2 0"Not_eligible" 1"Democratic" 2"Republican" 3"Libertarian" 4"Green" 5"Other" 6"None"
# label value uspartyipf party2
# tab1 uspartyipf,m
# 
# lab def politid 1"Anarchist" 2"Conservative" 3"Green" 4"Liberal" 5"Libertarian" 6"Progressive" 7"Socialist" 8"Other" 9"Non-political"
# lab val politicalid politid
# 
# *Clean sexattraction
# lab def attraction 1"Only_females" 2"Mostly_females" 3"Equally" 4"Mostly_males" 5"Only_males" 6"Im_not_sure" 7"No_attraction"
# lab value sexattraction attraction
# tab1 sexattraction,m
# gen sexattraction2=sexattraction
# recode sexattraction2 (1=5) (2=4) (5=1) (4=2) if gender==1
# recode sexattraction2 (5=1) (4=2) if gender==2
# lab def sexattraction2 1"Only_opp_sex" 2"Mostly_opp_sex" 3"Equally" 4"Mostly_same_sex" 5"Only_same_sex" 6"Im_not_sure" 7"No_attraction"
# lab value sexattraction2 sexattraction2
# tab1 sexattraction2,m
# 
# *Clean sexorientation
# label def so 1"Heterosexual" 2"Gay_Lesbian" 3"Bisexual" 4"Bicurious" 5"Asexual" 6"Refuse_labels"
# label val sexorientation so
# tab sexorientation
# gen het=0
# replace het=1 if sexorientation==1
# replace het=. if sexorientation==.
# gen gaylesb=0
# replace gaylesb=1 if sexorientation==2
# replace gaylesb=. if sexorientation==.
# gen bisex=0
# replace bisex=1 if sexorientation==3
# replace bisex=. if sexorientation==.
# gen bicur=0
# replace bicur=1 if sexorientation==4
# replace bicur=. if sexorientation==.
# gen asex=0
# replace asex=1 if sexorientation==5
# replace asex=. if sexorientation==.
# gen refusesexlabels=0
# replace refusesexlabels=1 if sexorientation==6
# replace refusesexlabels=. if sexorientation==.
# lab val het gaylesb bisex bicur asex refusesexlabels yn
# gen lgbt=gaylesb+bisex+trans
# recode lgbt (1/5=1)
# lab value lgbt yn
# tab1 lgbt
# 
# *Clean married & openrelat
# recode married (3=0)(2=1)(1=2)(4=3)
# lab def married 0"No" 1"In_relationship" 2"Married" 3"Its_complicated"
# lab val married married
# tab married
# replace openrelat=4 if married==3 & openrelat==.
# replace openrelat=0 if married==0 & openrelat==.
# lab def open 0"No_relationship" 1"Not_open" 2"Somewhat_open" 3"Open" 4"Its_complicated"
# lab val openrelat open
# tab married openrelat,m
# 
# *Clean spirituality
# lab def spirit 1"Religious" 2"Spiritual_not_relig" 3"Atheist" 4"Agnostic" 5"Deist" 6"IDK"
# lab value spirituality spirit
# tab1 spirituality,m
# 
# *Clean religion (RECODING OF OTHER COULD BE DONE)
# lab def rel 1"No_religion" 2"Protestant" 3"Catholic" 4"Christian_other" 5"Jewish" 6"Buddhist" 7"Pastafarian" 8"Pagan" 9"Muslim" 10"Hindu" 11"Other" 
# lab value religion rel
# tab1 religion,m
# *Cleaning religionother (NOT FINISHED)
# replace religionother=lower(religionother)
# replace religionother = subinstr(religionother,"."," ",5)
# replace religionother = subinstr(religionother,","," ",4)
# replace religionother = subinstr(religionother,"-"," ",4)
# replace religionother = subinstr(religionother,"("," ",4)
# replace religionother = subinstr(religionother,")"," ",4)
# replace religionother = subinstr(religionother,"/"," ",4)
# replace religionother = subinstr(religionother,"!"," ",4)
# replace religionother = subinstr(religionother,"a ","",4)
# replace religionother = subinstr(religionother,"an ","",4)
# replace religionother = subinstr(religionother,"  "," ",4)
# replace religionother =regexr(religionother,"^.*(witch|wicc|paga|shaman|mother earth|druid|earth based spi|animis|aminis|nature|sun worship|wizard|pagbased|pegan).*$","pagan")
# replace religionother =regexr(religionother,"^.*(non denom|athe|humani|non pract|secul|religion is garbage|religion is the opiat|athie|agnos|jewish by |not practicing|non theist|not christ|anarch|scientist|born jew|culturally |yogi non rel|free|evolution).*$","No_rel")
# replace religionother =regexr(religionother,"^.*(tao|dao).*$","taoism")
# replace religionother =regexr(religionother,"^.*(native|trad).*$","native_rel")
# replace religionother =regexr(religionother,"^.*(morm|lds|latter day saint).*$","mormon")
# replace religionother =regexr(religionother,"^.*(my |i have my |i am into me|free think|both you and i|confidence|church of get the f|i take what i want|taking in what|meee).*$","self-centered")
# replace religionother =regexr(religionother,"^.*(one |open |all |believe|born jewish praying for all|church of love|everything|flow|he who is named|i believe in real).*$","general-universal-love")
# replace religionother =regexr(religionother,"^.*(i belong to all|integral|interfaith|life|living in|lov|part of the univ|the univers|u univers|universal|unity|waao|i am god thou|diverse |acceptance|agape|oneness|power of now).*$","general-universal-love")
# replace religionother =regexr(religionother,"^.*(human|interest|alcaedas|alcoh|aliv|artist|awe|child of |conscious|cool|created|earth|i am who i am|i don|its personal|jerk|lost|pick up|smorgashboard|to be|uhg idk|unintel|uninvers|what i yam|yes i am|uu|uva|citizen|art of living).*$","comment")
# *Recoding some others into religion
# replace religion=8 if regexm(religionother,"pagan")==1 & religion==11
# replace religionother =regexr(religionother,"pagan","")
# replace religion=1 if regexm(religionother,"No_rel")==1
# replace religionother =regexr(religionother,"No_rel","")
# replace religion=4 if regexm(religionother,"mormon")==1
# replace religionotherChr="mormon" if regexm(religionother,"mormon")==1
# replace religionother =regexr(religionother,"mormon","")
# tab religionother if religion==11,m
# tab religion,m
# tab religion if religion!=1
# 
# *Clean bmevents
# lab def events 1"Yes_attended" 2"Yes_volunteered" 3"No_but_email_list" 4"No"
# lab value bmevents events
# tab1 bmevents,m
# 
# *Clean bminvolve
# recode bminvolve_prod-bminvolve_other bminvolve_not (1/9=1)
# egen involvecount=anycount(bminvolve_prod-bminvolve_other bminvolve_not), v(1)
# tab involvecount 
# recode bminvolve_prod-bminvolve_other bminvolve_not (.=0) if involvecount>=1 |bmevents==1|bmevents==3|bmevents==4
# recode bmevents (2=1) if bminvolve_not==1
# recode  bminvolve_prod-bminvolve_other bminvolve_not (0=.)(1=.) if bminvolve_not==1 & involvecount>=2
# drop involvecount bminvolve_not
# label val bminvolve_prod-bminvolve_other yn
# 
# *Clean bminfo
# recode bminfojrs-bminfowom (1=0)(2=1)(3=2)
# lab def bminfo 0"Never" 1"Rarely" 2"Often"
# lab val bminfojrs-bminfowom bminfo
# 
# *Clean valuedinfo
# recode valued_brcevents-valued_other (1/10=1)
# egen valuedcount=anycount(valued_brcevents-valued_other), v(1)
# tab valuedcount 
# recode valued_brcevents-valued_other (.=0) if valuedcount!=0 
# drop valuedcount 
# label val valued_brcevents-valued_other yn
# tab1 valued_brcevents-valued_other,m
# 
# *Clean bmir & bmgr
# recode bmir_online- bmir_no (1/9=1)
# label val bmir* yn
# egen bmirsourcescount=anycount(bmir_online bmir_travelmobile bmir_brcair bmir_centercamp), v(1)
# recode bmir* (.=0) if bmirsourcescount>=1 | bmir_didntknow==1| bmir_no==1
# recode bmir* (1=.)(0=.) if bmirsourcescount>=1 & bmir_didntknow==1
# recode bmir* (1=.)(0=.) if bmirsourcescount>=1 & bmir_no==1
# recode bmir* (1=.)(0=.) if bmir_didntknow==1 & bmir_no==1
# recode bmirsourcescount (0=.) if bmir_online==.
# tab1 bmir_online bmir_travelmobile bmir_brcair bmir_centercamp bmir_didntknow bmir_no bmirsourcescount,m
# replace bmgr=bmgr-1
# lab def bmgr 0"Heard_of_it_but_never_listened" 1"I_listened_to_it" 2"Not_heard_of_it"
# lab val bmgr bmgr
# 
# *Clean bmprograms
# recode bmprogramsbwb bmprogramsbma bmprogramsbrs bmprogramsbmrn (3=0)(2=1)(1=2)
# lab def bmprog 0"No" 1"Heard_of_it" 2"Yes"
# lab val bmprogramsbwb bmprogramsbma bmprogramsbrs bmprogramsbmrn bmprog
# 
# *Volunteering, skills & certifications
# recode volunteerbrc-volunteerother (1/10=1)
# egen voluntcount=anycount(volunteerbrc-volunteerother), v(1)
# tab voluntcount 
# recode volunteerbrc-volunteerother (.=0)
# recode volunteerbrc-volunteerother(0=.) if voluntcount==0 & prinimport==. & princchange==. & princwork==. & volunteerinspired==.
# label val volunteerbrc-volunteerother yn
# tab1 volunteerbrc-volunteerother,m
# drop voluntcount 
# recode volunteerinspired (2=0)(3=1)(1=2)
# lab def nmy 0"No" 1"Maybe" 2"Yes"
# lab val volunteerinspired nmy
# 
# recode skillcreation-skillother (1/10=1)
# egen skillcount=anycount(skillcreation-skillother), v(1)
# recode skillcreation-skillother (.=0) 
# recode skillcreation-skillother (0=.) if skillcount==0 & volunteerinspired==. & skilluseful==. & burnerid==.
# label val skillcreation-skillother yn
# tab1 skillcreation-skillother,m
# 
# recode skilluseful (4=0)(3=1)(2=2)(1=3)
# lab def skilluseful 0"Not_at_all" 1"Not_for_now" 2"Yes_somewhat_useful" 3"Yes_very_useful"
# lab val skilluseful skilluseful
# recode skillusefam-skillusebrc (1/5=1)
# recode skillusefam-skillusebrc (.=0) if skillcount>0
# lab val skillusefam-skillusebrc yn
# recode certifosha-certiffiresafety (4=0)(3=1)(2=2)(1=3)
# lab def certif 0"No" 1"Held_but_not_used" 2"Used_at_BM" 3"Earned_because_of_BM"
# label val certifosha-certiffiresafety certif
# recode certifosha-certiffiresafety (.=0) if certifosha!=.|certifhippa!=.| certifcpr!=.| certiffoodsafety!=.| certifmachinery!=.| certiffiresafety!=.| burnerid!=.
# tab1 certifosha-certiffiresafety,m
# 
# *Clean year round BM
# recode yearround (2=0)(1=1)(3=2)
# lab def yrround 0"No" 1"Yes" 2"I_dont_care"
# lab val yearround yrround
# tab yearroun
# 
# *Clean arrival/leaving 
# lab def date 1"PreWed23" 2"Wed23" 3"Thu24" 4"Fri25" 5"Sat26" 6"Sun27" 7"Mon28" 8"Tue29" 9"Wed30" 10"Thu31" 11"Fri1" 12"Sat2" 13"Sun3" 14"Mon4" 15"Tue5" 16"PostTue5"
# lab def date2 5"Preevent" 6"Sun27" 7"Mon28" 8"Tue29" 9"Wed30" 10"Thu31" 11"Fri1" 12"Sat2" 13"Sun3" 14"Mon4" 15"Tue5" 16"PostTue5"
# lab value arrival date
# lab value leaving date2
# replace leaving=leaving+4
# *(correct when leaving on the first Sun/Mon instead of the last if arrival does not fit. corrects 87 cases)
# recode leaving (6=13) if arrival>6
# recode leaving (7=14) if arrival>7
# gen bugdate=arrival-leaving
# replace bugdate=. if arrival==.|leaving==.
# replace arrival=. if bugdate>0 & bugdate<10
# replace leaving=. if bugdate>0 & bugdate<10
# drop bugdate
# *Create arrival2 variable
# recode arrival (1/3=1)(4=2)(4=2)(5=3)(6=4)(7=5)(8=6)(9=7)(10=8)(11=9)(12=10)(13/16=11) , gen(arrival2)
# lab def date3 1"PreFri23" 2"Fri25" 3"Sat26" 4"Sun27" 5"Mon28" 6"Tue29" 7"Wed30" 8"Thu31" 9"Fri1" 10"Sat2" 11"PostSat2"
# lab val arrival2 date3
# *Create early arrival variable
# recode arrival (1/5=1) (6/16=0)(.=0) , gen(early)
# lab val early yn
# tab arrival
# *Create length of stay
# gen lengthofstay=leaving-arrival+1
# replace lengthofstay=. if leaving==5 | arrival==15 | arrival==16
# 
# *Clean principles
# replace princf_incl="0" if princf_incl==""
# replace princf_gift="0" if princf_gift==""
# replace princf_decom="0" if princf_decom==""
# replace princf_reli="0" if princf_reli==""
# replace princf_expr="0" if princf_expr==""
# replace princf_commu="0" if princf_commu==""
# replace princf_resp="0" if princf_resp==""
# replace princf_lnt="0" if princf_lnt==""
# replace princf_part="0" if princf_part==""
# replace princf_immed="0" if princf_immed==""
# destring princf_incl-princf_immed, replace force
# recode princf_incl-princf_immed (.=1)
# recode princd_incl-princd_immed (1/99999=1)
# egen princcount=anycount(princf_incl-princf_immed princd_incl-princd_immed), v(1)
# tab princcount 
# recode princf_incl-princf_immed princd_incl-princd_immed(.=0) if princcount>=1 
# recode princf_incl-princf_immed princd_incl-princd_immed(0=.) if princcount==0 
# label val princf_incl-princf_immed princd_incl-princd_immed yn
# tab1 princf_incl-princf_immed,m
# tab1 princd_incl-princd_immed,m
# drop princcount 
# recode prinimport prinessent (5=0)(4=1)(3=2)(2=3)(1=4)
# lab def princ 0"Not_imp" 1"Slightly_imp" 2"Moderately_imp" 3"Important" 4"Very_imp"
# lab val prinimport prinessent princ
# tab1 prinimport prinessent,m 
# 
# recode princchange (2=0)(1=1)(3=2)
# recode princwork (3=0)
# lab def princchange 0"No" 1"Yes" 2"Yes_and_burners_are_responsible"
# lab def princwork 0"No" 1"I_try_to_practice_them" 2"I_have_modeled_my_activities_on_them"
# lab val princchange princchange
# lab val princwork princwork
# 
# *Clean travel variables (qualitative could be recoded)
# recode travelbrc (2=3)(3=4)(4=2)
# lab def travelbrc 1"Gate" 2"Point_1" 3"Burner_Express" 4"Other_shuttle" 5"Airport" 6"Other"
# lab val travelbrc travelbrc
# tab1 travelbrc*
#   recode fly (1=0)
# replace fly=1 if travelbrc==5
# lab def fly 0"No" 1"BRC" 2"Reno" 3"Sacramento" 4"SF" 5"Oakland" 6"Las_Vegas" 7"LA" 8"Other"
# lab val fly fly
# tab1 fly*
#   
#   *Clean nbvehicle
# recode nbvehicle (0=1)
# recode nbvehicle (10/19=10)(20/120=11)
# replace nbvehicle=12 if nbvehicle==. & travelbrc!=1 & travelbrc!=2 & travelbrc!=.
# lab def nbvehicle 10"_10to19" 11"_20_or_more" 12"NA"
# lab val nbvehicle nbvehicle 
# 
# replace nb012vehicle=0 if nb012vehicle==. & nbvehicle!=.
# replace nb012vehicle=. if nbvehicle==.
# replace nb012vehicle=nbvehicle-1 if nb012vehicle>=nbvehicle
# recode nb012vehicle (2/12=2), gen(nb012vehicle2)
# lab def nb012 2"_2_or_more" 3"NA"
# lab val nb012vehicle2 nb012
# tab nb012vehicle2
# replace nb1317vehicle=0 if nb1317vehicle==. & nbvehicle!=.
# replace nb1317vehicle=. if nbvehicle==.
# replace nb1317vehicle=nbvehicle-1 if nb1317vehicle>=nbvehicle
# recode nb1317vehicle (2/10=2), gen (nb1317vehicle2)
# lab val nb1317vehicle2 nb012
# tab nb1317vehicle2
# 
# replace nbvehicle=nb012vehicle+nb1317vehicle+1 if nb012vehicle+nb1317vehicle>=nbvehicle & nb012vehicle+nb1317vehicle<=10
# recode nbvehicle (6/7=6)(8/9=7)(10=8)(11=9) (12=10), gen(nbvehicle2)
# lab def nbvehicle2 6"_6or7" 7"_8or9" 8"_10to19" 9"_20_or_more" 10"NA"
# lab val nbvehicle2 nbvehicle2 
# tab nbvehicle nbvehicle2
# 
# gen nb017vehicle=nb012vehicle+nb1317vehicle
# recode nb017vehicle (2/20=2)
# lab val nb017vehicle nb012
# tab nb017vehicle
# replace nb012vehicle=3 if nbvehicle==12
# replace nb1317vehicle=3 if nbvehicle==12
# replace nb017vehicle=3 if nbvehicle==12
# 
# *Clean vehicletype (there is a lot of others)
# replace vehicletype=10 if travelbrc>2 & travelbrc<7 
# lab def vehicletype 1"Motorcycle" 2"Car" 3"SUV" 4"Pickup" 5"Truck_wt_trailer" 6"SemiTruck_wt_trailer" 7"Bus" 8"RV" 9"Other" 10"NA"
# lab val vehicletype vehicletype
# tab vehicletype
# 
# *Clean bxb
# lab val bxb_* yn
# recode bxb_* (1/9=1)
# egen bxbcount=anycount(bxb_sftobrc bxb_brctosf bxb_renotobrc bxb_brctoreno), v(1)
# recode bxb_renotobrc (1=0) if bxb_sftobrc==1
# recode bxb_brctoreno (1=0) if bxb_brctosf==1
# gen bxbtravel=1 if bxb_sftobrc==1 & bxbcount==1
# replace bxbtravel=2 if bxb_renotobrc==1 & bxbcount==1
# replace bxbtravel=3 if bxb_brctosf==1 & bxbcount==1
# replace bxbtravel=4 if bxb_brctoreno==1 & bxbcount==1
# replace bxbtravel=5 if bxb_sftobrc==1 & bxb_brctosf==1 & bxbcount==2
# replace bxbtravel=6 if bxb_brctoreno==1 & bxb_renotobrc==1 & bxbcount==2
# replace bxbtravel=7 if bxb_sftobrc==1 & bxb_brctoreno==1 & bxbcount==2
# replace bxbtravel=8 if bxb_brctosf==1 & bxb_renotobrc==1 & bxbcount==2
# lab def bxbtravel 1"SFtoBRC" 2"RenotoBRC" 3"BRCtoSF" 4"BRCtoReno" 5"SFtoBRCtoSF" 6"RenotoBRCtoReno" 7"SFtoBRCtoReno" 8"RenotoBRCtoSF"
# lab val bxbtravel bxbtravel
# drop bxbcount
# tab bxbtravel,m
# recode bxbcamp (1=0)(3=1)(2=2)(4=3)
# lab def bxbcamp 0"no" 2"yes_and_would_again" 1"yes_but_would_not_again" 3"idk"
# lab val bxbcamp bxbcamp
# tab bxbcamp,m
# recode bxbshuttle (2=0)(3=2)
# lab def bxbshuttle 1"yes" 0"no" 2"idk"
# lab val bxbshuttle bxbshuttle
# tab bxbshuttle,m
# 
# recode bxbforcost-bxbforother (1/99=1)
# egen bxbcount2=anycount(bxbforcost-bxbforother), v(1)
# recode bxbforcost-bxbforother (.=0) if bxbcount2>=1
# lab val bxbforcost bxbfornodriving bxbforgatetraffic bxbforroadcongestion bxbforasbefore bxbforother yn
# tab1 bxbforcost-bxbforother
# recode bxbprice (2=3)(3=2)
# lab def bxbprice 1"underpriced" 3"overpriced" 2"right_price"
# lab val bxbprice bxbprice
# replace bxbexp=11-bxbexp
# replace bxbticketexp=11-bxbticketexp
# lab def bxbexp 1"absolutely_fantastic" 10"terrible"
# lab val bxbticketexp bxbexp bxbexp
# tab1 bxbprice bxbexp bxbticketexp
# 
# *Clean tickets (many others should be recategorized as BMdirect/staff)
# recode ticketwhere (11=0)(12=1)
# lab def ticketwhere 0"BM_presale" 1"BM_mainsale" 2"BMdirectdistrib" 3"BMlowincomeprg" 4"STEP" 5"Someone_I_know" 6"Stranger" 7"Third_party_reseller" 8"Kids_ticket" 9"No_ticket" 10"Other"
# lab val ticketwhere ticketwhere
# tab1 ticketwhe*,m
# 
# replace ticketwhere=5  if ticketcost==4 & (ticketwhere==0|ticketwhere==1|ticketwhere==3|ticketwhere==4)
# recode ticketcost (. 1 2 3 5=2) if ticketwhere==0|ticketwhere==1| ticketwhere==2|ticketwhere==3|ticketwhere==4
# replace ticketcost=. if ticketwhere==8| ticketwhere==9
# lab def ticketcost 1"Less_than_facevalue" 2"Facevalue" 3"More_than_facevalue" 4"Gift" 5"IDK" 6"Other"
# lab val ticketcost ticketcost
# tab1 ticketcost*
#   tab ticketcost ticketwhere,m
# 
# *Clean $ variables
# replace bmspending = subinstr(bmspending,"$","",1)
# replace nvspendfuel = subinstr(nvspendfuel,"$","",1)
# replace nvspendfood = subinstr(nvspendfood,"$","",1)
# replace nvspendlodging = subinstr(nvspendlodging,"$","",1)
# replace nvspendsurvival = subinstr(nvspendsurvival,"$","",1)
# replace nvspendfun = subinstr(nvspendfun,"$","",1)
# replace nvspendfuel = subinstr(nvspendfuel,"-","",1)
# destring bmspen nvspen*, force replace
# recode nvspen* (.=0) if nvspendfuel!=.|nvspendfood!=.|nvspendlodging!=.|nvspendsurvival!=.|nvspendfun!=.
# recode bmspen nvspen* (9999999/99999999999999999999999=.)
# recode bmspending (0/249.99=1)(250/499.99=2)(500/999.99=3)(1000/2499.99=4)(2500/4999.99=5)(5000/999999999=6), gen(bmspendingcat)
# lab def bmspendingcat 1"_0to250USD" 2"_250to500USD" 3"_500to1000USD" 4"_1000to2500USD" 5"_2500to5000USD" 6"More_than_5000USD"
# lab val bmspendingcat bmspendingcat
# tab1 bmspending*
#   tab1 nvspend*,m
# 
# gen nvspendtotal=nvspendfuel+nvspendfood+nvspendlodging+nvspendsurvival+nvspendfun
# 
# replace nvspendfuel=. if nvspendtotal>999999999
# replace nvspendfood=. if nvspendtotal>999999999
# replace nvspendlodging=. if nvspendtotal>999999999
# replace nvspendsurvival=. if nvspendtotal>999999999
# replace nvspendfun=. if nvspendtotal>999999999
# replace nvspendtotal=. if nvspendtotal>999999999
# recode nvspendtotal (0/249.99=1)(250/499.99=2)(500/999.99=3)(1000/2499.99=4)(2500/4999.99=5)(5000/999999999=6), gen(nvspendtotal2)
# lab value nvspendtotal2 bmspendingcat
# tab1 nvspendtotal2,m
# 
# *Clean parkvisit
# lab def parkvisit 1"No" 2"Not_sure" 3"Yes_one_place" 4"Yes_2places_or_more"
# lab value parkvisit parkvisit
# tab1 parkvisit,m
# 
# *Clean waste sorting
# lab def waste 1"Yes" 2"No_but_someone_else_does" 3"No_but_it_gets_sorted" 4"No_It_goes_to_a_landfill" 5"IDK"
# lab val sortwaste waste
# recode sortburnable sortrecyc sortcompost sortother (1/9=1)
# lab val sortburnable sortrecyc sortcompost sortother yn
# recode sortburnable sortrecyc sortcompost sortother (.=0) if sortwaste!=.
# recode trashcampserv-trashother (1/99=1)
# recode trashcampserv-trashother (.=0) if trashcampserv!=.| trashggid!=.| trashexodusprg!=.| trashtransferstation!=.| trashdumpster!=.| trashfriend!=.| trashonmyway !=.|trashdropped!=.| trashhome!=.| trashbxb!=.| trashsomeone!=.| trashother!=.
# lab val trashcampserv trashggid trashexodusprg trashtransferstation trashdumpster trashfriend trashonmyway trashdropped trashhome trashbxb trashsomeone trashother yn 
# tab1 trashcampserv-trashother
# 
# *Clean nbcamp
# lab def nbcamp 3"_3to5" 4"_6to9" 5"_10to19" 6"_20to29" 7"_30to49" 8"_50to99" 9"_100to199" 10"_200_or_more"
# lab val nbcamp nbcamp
# tab nbcamp
# 
# *Clean rv
# recode rv (4=0)(5=1)(2=2)(3=3)(1=4)
# lab def rv 0"No" 1"Not_sure" 2"Yes_not_pumped" 3"Yes_idk_pumped" 4"Yes_and_pumped"
# lab value rv rv
# tab rv,m
# recode rv (2/4=2), gen(rv2)
# lab def rv2 0"No" 1"Not_sure" 2"Yes"
# lab value rv2 rv2
# lab def rvadults 1"only_me" 10"_10_or_more"
# lab val rvadults rvadults
# 
# *Clean nbfamily
# replace nbfamily=nbfamily-1
# lab def fam 6"_6_or_more"
# lab value nbfamily fam
# recode nbfamily (4/6=4), gen(nbfamily2)
# lab def fam2 4"_4_or_more"
# lab value nbfamily2 fam2
# tab1 nbfamily
# tab1 nbfamily2,m
# 
# *Clean children variables
# lab def minor 1"Yes_and_I_would_again" 2"Yes_but_I_would_not" 3"No_but_I_would" 4"No_I_would_not"
# lab val broughtminor minor
# tab broughtminor
# replace childban=childban-1
# lab def childban 0"No" 1"Yes_only18plus" 2"No_opinion"
# lab val childban childban
# tab childban
# 
# *Clean electrical power (STILL TO CODE: powerother_qual)
# recode powerno-powerother (1/99=1)
# recode powerno-powerother (.=0) if powerno!=.|powerbat!=.| powersol!=.| powerwind!=.| powervehic!=.| powercamp!=.| poweranot!=.| powergrid!=.| powerother!=.
# lab value powerno yn
# lab value powerbat yn
# lab value powersol yn
# lab value powerwind yn
# lab value powervehic yn
# lab value powercamp yn
# lab value poweranot yn
# lab value powerother yn
# lab value powergrid yn
# tab1 powerno-powerother
# 
# lab def fueltype 1"Gasoline" 2"Diesel" 3"Biodiesel" 4"Propane" 5"Other" 6"IDK" 7"Multiple_types"
# lab val vehicfueltype campfueltype fueltype
# drop vehicfueltypeother campfueltypeother
# recode vehicfueltype campfueltype (5=.)
# lab def campgenoutput 1"lessthan1kW" 2"_1kW" 3"_2kWto3kW" 4"_4kWto9kW" 5"_10kWto19kW"6"_20kWto39kW" 7"_40kW_or_more" 8"IDK"
# lab val campgenoutput campgenoutput 
# 
# *Clean burnerid
# recode burnerid (2=0)(3=1)(1=2)
# lab def burnerid 0"No" 1"Sort_of" 2"Yes"
# lab val burnerid burnerid
# tab burnerid,m
# 
# *Clean donation
# replace don_artus = subinstr(don_artus,"$","",1)
# replace don_artabroad = subinstr(don_artabroad,"$","",1)
# replace don_commun = subinstr(don_commun,"$","",1)
# replace don_brcplan = subinstr(don_brcplan,"$","",1)
# replace don_lowincome = subinstr(don_lowincome,"$","",1)
# replace don_artplaya = subinstr(don_artplaya,"$","",1)
# replace don_regional = subinstr(don_regional,"$","",1)
# replace don_other = subinstr(don_other,"$","",1)
# destring don_artus-don_other, force replace
# recode don_artus-don_other (.=0) if don_artus!=.| don_artabroad!=.| don_commun!=.| don_brcplan!=.| don_lowincome!=.| don_artplaya!=.| don_regional!=.| don_other!=.
# gen donatetot=don_artus+don_artabroad+don_commun+don_brcplan+don_lowincome+don_artplaya+don_regional+don_other
# tab donatetot
# replace don_artus=100*don_artus/donatetot if donatetot>100
# replace don_artabroad=100*don_artabroad/donatetot if donatetot>100
# replace don_commun=100*don_commun/donatetot if donatetot>100
# replace don_brcplan=100*don_brcplan/donatetot if donatetot>100
# replace don_lowincome=100*don_lowincome/donatetot if donatetot>100
# replace don_artplaya=100*don_artplaya/donatetot if donatetot>100
# replace don_regional=100*don_regional/donatetot if donatetot>100
# replace don_other=100*don_other/donatetot if donatetot>100
# drop donatetot
# 
# *Clean address
# lab def letter 1"A" 2"B" 3"C" 4"D" 5"E" 6"F" 7"G" 8"H" 9"I" 10"J" 11"K" 12"L" 13"Esplanade" 14"Rods_road" 15"Inner_ring" 16"Walk_in" 17"DPW_depot" 18"ESD" 19"Airport"
# lab val address_letter letter
# recode address_hour (1=200) (2=230) (3=300) (4=330) (5=400) (6=430) (7=500) (8=530) (9=600) (10=630) (11=700) (12=730) (13=800) (14=830) (15=900) (16=930) (17=1000)
# lab val address_hour .
# 
# *Clean assignedcamp
# lab def ynidk 1"Yes" 2"No" 3"IDK"
# lab val assignedcamp ynidk
# 
# *Clean choice of location (if not assigned)
# recode locationattract-locationidk (1/11=1)
# replace locationidk=0 if locationattract==1| locationsurface==1| locationfriend==1| locationavailable==1| locationneighbors==1| locationsamelastyear==1| locationdifflastyear==1| locationquiet==1| locationparties==1
# recode locationattract-locationidk (.=0) if locationidk==1 | locationattract==1| locationsurface==1| locationfriend==1| locationavailable==1| locationneighbors==1| locationsamelastyear==1| locationdifflastyear==1| locationquiet==1| locationparties==1
# lab value locationattract-locationidk yn
# 
# *Clean brc safe/connected
# replace brcsafe=5-brcsafe
# replace brcconnect=5-brcconnect
# lab def safe 0"Very_unsafe" 1"Mostly_unsafe" 2"Neither_nor" 3"Mostly_safe" 4"Very_safe"
# lab val brcsafe safe
# tab1 brcsafe,m
# lab def connect 0"Very_disconnected" 1"Mostly_disconnected" 2"Neither_nor" 3"Mostly_connected" 4"Very_connected"
# lab val brcconnect connect
# tab1 brcconnect,m
# 
# *Clean money
# destring money, force replace
# replace money=money-1
# recode money (5=3)
# lab def money 0"Never" 1"Once" 2"_2_to_3_times" 3"_4_to_5_times" 4"More_than_5_times"
# lab val money money
# 
# *Clean enjoy
# replace enjoy=enjoy-1
# lab def extremely 0"No" 1"A_bit" 2"Somewhat" 3"A_lot" 4"Extremely"
# lab val enjoy extremely
# tab enjoy
# 
# *Clean intend
# replace intend=intend-1
# lab def absolutely 0"Absolutely_not" 1"Probably_not" 2"Not_sure" 3"Probably" 4"Absolutely"
# lab val intend absolutely
# tab intend
# 
# *Clean burnerfamily
# replace burnerfamily=burnerfamily-1
# lab val burnerfamily extremely
# tab burnerfamily
# 
# *Attainments, contributions, public lands
# lab def desire 1"Not_at_all" 5"Very_high" 6"IDK"
# lab val desirereli-attainecotour desire
# tab1 desirereli-attainecotour
# lab val contribthink- contribmeet desire
# tab1 contribthink- contribmeet
# recode publiccamping-publicother (1/99=1)
# egen publiccount=anycount(publiccamping-publicother), v(1)
# recode publiccamping-publicother (.=0) if contribmeet!=. |intend!=.|publiccount>=1
# lab val publiccamping-publicother yn
# 
# *Nevadacities
# replace nevadacities=lower(nevadacities)
# replace nevadacities = subinstr(nevadacities,"none","",1)
# replace nevadacities = subinstr(nevadacities,"black rock","",1)
# replace nevadacities ="" if nevadacities=="0"
# 
# gen reno=1 if regexm(nevadacities,"^.*(reno|remo).*$")==1
# replace nevadacities = subinstr(nevadacities,"reno","",1)
# replace nevadacities = subinstr(nevadacities,"remo","",1)
# 
# gen sparks=1 if regexm(nevadacities,"^.*(spark).*$")==1
# replace nevadacities = subinstr(nevadacities,"sparks","",1)
# replace nevadacities = subinstr(nevadacities,"spark","",1)
# gen empire=1 if regexm(nevadacities,"^.*(empire|impire).*$")==1
# replace nevadacities = subinstr(nevadacities,"empire","",1)
# replace nevadacities = subinstr(nevadacities,"impire","",1)
# gen carson=1 if regexm(nevadacities,"^.*(carson).*$")==1
# replace nevadacities = subinstr(nevadacities,"carson city","",1)
# replace nevadacities = subinstr(nevadacities,"carson","",1)
# gen gerlach=1 if regexm(nevadacities,"^.*(gerl|gearl|geelac|garl|getl|gurl|guirl|guerl|gelac|gelr|gilri|girl).*$")==1
# replace nevadacities = subinstr(nevadacities,"gerlach","",1)
# replace nevadacities = subinstr(nevadacities,"gearlach","",1)
# replace nevadacities = subinstr(nevadacities,"garlach","",1)
# replace nevadacities = subinstr(nevadacities,"geelach","",1)
# replace nevadacities = subinstr(nevadacities,"gerlacj","",1)
# replace nevadacities = subinstr(nevadacities,"gerlack","",1)
# replace nevadacities = subinstr(nevadacities,"gerloch","",1)
# replace nevadacities = subinstr(nevadacities,"gerlock","",1)
# replace nevadacities = subinstr(nevadacities,"getlach","",1)
# replace nevadacities = subinstr(nevadacities,"gurlatch","",1)
# replace nevadacities = subinstr(nevadacities,"gurlock","",1)
# replace nevadacities = subinstr(nevadacities,"gurluch","",1)
# replace nevadacities = subinstr(nevadacities,"gurlach","",1)
# replace nevadacities = subinstr(nevadacities,"guirlach","",1)
# replace nevadacities = subinstr(nevadacities,"guerlach","",1)
# replace nevadacities = subinstr(nevadacities,"gilrich","",1)
# replace nevadacities = subinstr(nevadacities,"gelrach","",1)
# replace nevadacities = subinstr(nevadacities,"gelach","",1)
# replace nevadacities = subinstr(nevadacities,"gerlatch","",1)
# replace nevadacities = subinstr(nevadacities,"gerlak","",1)
# replace nevadacities = subinstr(nevadacities,"gerlich","",1)
# replace nevadacities = subinstr(nevadacities,"girlock","",1)
# replace nevadacities = subinstr(nevadacities,"gurlac","",1)
# replace nevadacities = subinstr(nevadacities,"gerlac","",1)
# gen fernley=1 if regexm(nevadacities,"^.*(fern|ferl|fenl|fearnl|furnl|finley|farle).*$")==1
# replace nevadacities = subinstr(nevadacities,"fernley","",1)
# replace nevadacities = subinstr(nevadacities,"fernlee","",1)
# replace nevadacities = subinstr(nevadacities,"fernleigh","",1)
# replace nevadacities = subinstr(nevadacities,"furnley","",1)
# replace nevadacities = subinstr(nevadacities,"finley","",1)
# replace nevadacities = subinstr(nevadacities,"fearnley","",1)
# replace nevadacities = subinstr(nevadacities,"fernly","",1)
# replace nevadacities = subinstr(nevadacities,"fenley","",1)
# replace nevadacities = subinstr(nevadacities,"fernnly","",1)
# replace nevadacities = subinstr(nevadacities,"ferneley","",1)
# replace nevadacities = subinstr(nevadacities,"fernely","",1)
# replace nevadacities = subinstr(nevadacities,"fernelly","",1)
# replace nevadacities = subinstr(nevadacities,"fernlay","",1)
# replace nevadacities = subinstr(nevadacities,"farley","",1)
# replace nevadacities = subinstr(nevadacities,"ferny","",1)
# replace nevadacities = subinstr(nevadacities,"ferlly","",1)
# replace nevadacities =regexr(nevadacities,"^.*(winn|winim|winem).*$","winnemucca")
# gen winnemucca=1 if regexm(nevadacities,"^.*(winn|winim|winem|wina).*$")==1
# replace nevadacities = subinstr(nevadacities,"winnemucca","",1)
# replace nevadacities = subinstr(nevadacities,"winnemucka","",1)
# replace nevadacities = subinstr(nevadacities,"winnemukka","",1)
# replace nevadacities = subinstr(nevadacities,"winnimuca","",1)
# replace nevadacities = subinstr(nevadacities,"winnumukah","",1)
# replace nevadacities = subinstr(nevadacities,"winamuuca","",1)
# replace nevadacities = subinstr(nevadacities,"winamucka","",1)
# replace nevadacities = subinstr(nevadacities,"winamucca","",1)
# 
# gen lovelock=1 if regexm(nevadacities,"^.*(lovel).*$")==1
# replace nevadacities = subinstr(nevadacities,"lovelock","",1)
# replace nevadacities = subinstr(nevadacities,"lovely","",1)
# gen elko=1 if regexm(nevadacities,"^.*(elko|elco).*$")==1
# replace nevadacities = subinstr(nevadacities,"elko","",1)
# replace nevadacities = subinstr(nevadacities,"elco","",1)
# gen yerrington=1 if regexm(nevadacities,"^.*(yer).*$")==1
# replace nevadacities = subinstr(nevadacities,"yerrington","",1)
# replace nevadacities = subinstr(nevadacities,"yerington","",1)
# replace nevadacities = subinstr(nevadacities,"yernington","",1)
# gen lasvegas=1 if regexm(nevadacities,"^.*(vegas|vargas).*$")==1
# replace nevadacities = subinstr(nevadacities,"las vegas","",1)
# replace nevadacities = subinstr(nevadacities,"las vargas","",1)
# replace nevadacities = subinstr(nevadacities,"vegas","",1)
# gen laketahoe=1 if regexm(nevadacities,"^.*(taho|tshoe).*$")==1
# replace nevadacities = subinstr(nevadacities,"lake tahoe","",1)
# replace nevadacities = subinstr(nevadacities,"lake tshoe","",1)
# replace nevadacities = subinstr(nevadacities,"lake taho","",1)
# replace nevadacities = subinstr(nevadacities,"tahoe","",1)
# gen fallon=1 if regexm(nevadacities,"^.*(fallon|falon).*$")==1
# replace nevadacities = subinstr(nevadacities,"fallon","",1)
# replace nevadacities = subinstr(nevadacities,"falon","",1)
# gen wendover=1 if regexm(nevadacities,"^.*(wend|wndov).*$")==1
# replace nevadacities = subinstr(nevadacities,"west wendover","",1)
# replace nevadacities = subinstr(nevadacities,"wendover","",1)
# replace nevadacities = subinstr(nevadacities,"wndover","",1)
# gen wadsworth=1 if regexm(nevadacities,"^.*(wadsw|wandsw|wadw).*$")==1
# replace nevadacities = subinstr(nevadacities,"wadsworth","",1)
# replace nevadacities = subinstr(nevadacities,"wadworth","",1)
# replace nevadacities = subinstr(nevadacities,"wadswrth","",1)
# replace nevadacities = subinstr(nevadacities,"wandsworth","",1)
# replace nevadacities = subinstr(nevadacities,"wadswarth","",1)
# gen pyramidlake=1 if regexm(nevadacities,"^.*(pyram|piram|pyrm|paiute).*$")==1
# replace nevadacities = subinstr(nevadacities,"pyramid lake","",1)
# replace nevadacities = subinstr(nevadacities,"lake pyramid","",1)
# replace nevadacities = subinstr(nevadacities,"piramid lake","",1)
# replace nevadacities = subinstr(nevadacities,"pyrmid lake","",1)
# replace nevadacities = subinstr(nevadacities,"pyramind lake","",1)
# replace nevadacities = subinstr(nevadacities,"pyramide lake","",1)
# gen nixon=1 if regexm(nevadacities,"^.*(nix|dixon).*$")==1
# replace nevadacities = subinstr(nevadacities,"nixon","",1)
# replace nevadacities = subinstr(nevadacities,"nixion","",1)
# replace nevadacities = subinstr(nevadacities,"dixon","",1)
# gen cedarville=1 if regexm(nevadacities,"^.*(cedar|ceder).*$")==1
# replace nevadacities = subinstr(nevadacities,"cedarville","",1)
# replace nevadacities = subinstr(nevadacities,"cedarsville","",1)
# replace nevadacities = subinstr(nevadacities,"cedar hills","",1)
# replace nevadacities = subinstr(nevadacities,"cederville","",1)
# replace nevadacities = subinstr(nevadacities,"reno","",1)
# replace nevadacities = subinstr(nevadacities,"reno","",1)
# gen verdi=1 if regexm(nevadacities,"^.*(verd).*$")==1
# replace nevadacities = subinstr(nevadacities,"verdi","",1)
# replace nevadacities = subinstr(nevadacities,"verde","",1)
# gen tonopah=1 if regexm(nevadacities,"^.*(tonop|tonap|tonepath).*$")==1
# replace nevadacities = subinstr(nevadacities,"tonopah","",1)
# replace nevadacities = subinstr(nevadacities,"tonepath","",1)
# replace nevadacities = subinstr(nevadacities,"tonapah","",1)
# replace nevadacities = subinstr(nevadacities,"tonahpah","",1)
# replace nevadacities = subinstr(nevadacities,"tonohpah","",1)
# replace nevadacities = subinstr(nevadacities,"tonopa","",1)
# gen hawthorne=1 if regexm(nevadacities,"^.*(hawt).*$")==1
# replace nevadacities = subinstr(nevadacities,"hawthorne","",1)
# replace nevadacities = subinstr(nevadacities,"hawthorn","",1)
# gen boomtown=1 if regexm(nevadacities,"^.*(boom|bomt).*$")==1
# replace nevadacities = subinstr(nevadacities,"boomtown","",1)
# replace nevadacities = subinstr(nevadacities,"boom town","",1)
# replace nevadacities = subinstr(nevadacities,"bomtown","",1)
# gen beatty=1 if regexm(nevadacities,"^.*(beatty|beaty|beatry).*$")==1
# replace nevadacities = subinstr(nevadacities,"beatty","",1)
# replace nevadacities = subinstr(nevadacities,"beaty","",1)
# replace nevadacities = subinstr(nevadacities,"beatry","",1)
# 
# replace nevadacities = subinstr(nevadacities,"  "," ",10)
# replace nevadacities = subinstr(nevadacities,", ,",",",10)
# replace nevadacities = subinstr(nevadacities,"/"," ",10)
# replace nevadacities = subinstr(nevadacities,";"," ",10)
# replace nevadacities = subinstr(nevadacities,"&"," ",10)
# replace nevadacities = subinstr(nevadacities,"?"," ",10)
# replace nevadacities = subinstr(nevadacities,"-"," ",10)
# replace nevadacities = subinstr(nevadacities,"."," ",10)
# replace nevadacities = subinstr(nevadacities,"and"," ",10)
# replace nevadacities = subinstr(nevadacities,"  "," ",10)
# 
# replace nevadacities = subinstr(nevadacities,","," ",10)
# replace nevadacities = subinstr(nevadacities,"  "," ",20)
# replace nevadacities = subinstr(nevadacities,"  "," ",10)
# replace nevadacities ="" if nevadacities ==" "
# tab nevadacities
# recode reno-beatty (.=0)
# 
# *Clean intendbrd
# lab def ynmaybe 1"yes" 2"no" 3"maybe"
# lab val intendbrd ynmaybe
# 
# *Clean BRC/DW matrix
# lab def matrix 1"not_at_all_like_me" 9"Very_much_like_me"
# lab val smilebrcfriend-statusdw matrix 
# 
# *Clean artist
# recode artist (1=3)(2=1)(3=2)
# lab def art 1"No" 2"No_but_creative" 3"Yes"
# lab value artist art
# tab1 artist,m
# 
# *Reasons to go
# recode toexpart-toother (1/16=1)
# egen tocount=anycount(toexpart-toother), v(1)
# recode toexpart-toother (.=0) if tocount>=1
# lab val toexpart-toother yn
# 
# *transfo- censusposts
# *Clean transfo 
# lab def transfo 1"Not_at_all" 4"Somewhat" 7"Definitely"
# lab val transfo transfo
# tab transfo
# lab def transfoextent 1"Minimal_or_no" 7"Complete"
# lab val transfoextent transfoextent
# tab transfoextent
# lab def transfoexp 1"Not_at_all" 4"Somewhat" 7"Absolutely"
# lab val transfoexp transfodesire transfoexp
# tab1 transfoexp transfodesire
# recode transfoper (1=0)(2=2)(3=1)
# lab def transfoper 0"No" 2"Yes_and_still_feel" 1"Yes_but_went_away"
# lab val transfoper transfoper
# tab transfoper
# replace longchange=longchange-1
# replace longchange=8 if transfoper==2
# replace longchange=9 if transfoper==0
# lab def longchange 0"Lessthan1day" 1"_1to3days" 2"_3daysto1week" 3"_1to2weeks" 4"_2to3weeks" 5"_3to4weeks" 6"_4to5weeks" 7"_6+weeks" 8"Stillpersisting" 9"No_changes"
# lab val longchange longchange
# tab longchange
# lab val specexp-specglad bestintentions transfoexp
# tab1 specexp-bestintentions
# lab def selfother 1"A" 2"B" 3"C" 4"D" 5"E" 6"F" 7"G"
# lab val selfother selfother
# tab selfother
# 
# *playdw newfriendsdw
# lab val playdw newfriendsdw ynidk
# tab1 playdw newfriendsdw
# 
# recode notgonecost-notgoneother (1/16=1)
# egen notgonecount=anycount(notgonecost-notgoneother), v(1)
# recode notgonecost-notgoneother (.=0) if notgonecount>=1
# lab val notgonecost-notgoneother yn
# tab1 notgonecost- notgoneother
# recode notgonenoticketnb-notgonecostnb (.=0) if notgonecost!=.
# lab def notgone 0"None" 1"One" 2"Some_of_them" 3"Most_of_them" 4"All_of_them"
# lab val notgonenoticketnb-notgonecostnb notgone
# tab1 notgonenoticketnb-notgonecostnb
# 
# recode sampledgate-censusposts (1/15=1)
# egen censuscount=anycount(sampledgate-censusposts), v(1)
# recode sampledgate-censusposts (.=0) if censuscount>=1
# lab val sampledgate-censusposts yn
# tab1 sampledgate-censusposts
# drop notgonecount censuscount publiccount skillcount tocount
# 
# 
# *Get the Geodata variables for zip and postal code
# sort zipcode
# merge zipcode using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/GeoCoordinates/zip_code2016.dta", nokeep
# drop _merge
# rename latitude latitude2
# rename longitude longitude2
# sort postalcode
# merge postalcode using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/GeoCoordinates/ca_postal_code2012.dta", nokeep
# drop _merge
# replace latitude=latitude2 if latitude==.
# replace longitude=longitude2 if longitude==.
# drop longitude2 latitude2
# encode state, gen(state2)
# encode province, gen(province2)
# drop state province
# rename state2 state
# rename province2 province
# 
# 
# ***************************************
#   ***************************************
#   ***WEIGHTING AND DATABASE PREPARATION**
#   ***************************************
#   
#   *ID the completed forms (still not done for the burning nerds questions)
# *
#   egen nbrespat2=rowmiss(birth gender sex residence incomep educ ethno color usvote politicalid sexattraction sexorientation spirituality religion bmevents)
# replace nbrespat2=15-nbrespat2
# egen nbrespat3=rowmiss(bminfojrs bmgr bmprogramsbwb prinimport prinessent princchange princwork volunteerinspired burnerid yearround)
# replace nbrespat3=10-nbrespat3
# egen nbrespat3b=rowmiss(birth gender sex residence incomep educ ethno color usvote politicalid sexattraction sexorientation spirituality religion bmevents bminfojrs bmgr bmprogramsbwb prinimport prinessent princchange princwork volunteerinspired burnerid yearround)
# replace nbrespat3b=25-nbrespat3b
# egen nbrespat4=rowmiss(arrival leaving travelbrc ticketwhere ticketcost bmspending parkvisit sortwaste nbcamp rv nbfamily broughtminor childban address_letter assignedcamp)
# replace nbrespat4=15-nbrespat4
# egen nbrespat5=rowmiss(desirereli attainreli contribthink intendbrd smilebrcfriend statusbrc artist brcsafe burnerfamily enjoy intend transfo bestintentions playdw)
# replace nbrespat5=14-nbrespat5
# 
# tab1 nbresp* if nbrespat2>11,m
# tab1 nbrespat3 if nbrespat2<=11,m
# tab1 nbrespat4 if nbrespat2<=11 | nbrespat3<=7,m
# tab1 nbrespat4 if nbrespat3b<=17,m
# tab1 nbrespat5 if nbrespat2<=11 | nbrespat3<=7 | nbrespat4<=11,m
# 
# 
# 
# *There is around a thousands of respondents who mentioned that it was not their first time filling up a 2017 Census and it is puzzling (the same happened in 2016). 
# *However, a lot of them completed the survey to the end, i.e., they submitted it and skipped none or nearly none of the indicator variables.
# *My understanding is thus that these people could not complete their survey the first time (bc it cannot be saved) so they went through the process again. 
# *For next time, ask why they are doing it again. Because they had problems the first time? To look at the questions? For fun? Because they want to mess with the survey? Other?
#   *For now, I decided to keep the Firstfill==no if Completed==yes and nbrespat3b>=18. 
# 
# drop if firstfill==2 & completed=="Partial" 
# drop if firstfill==2 & nbrespat3b<18 
# 
# *Drop if more than 25% of missing on indicators
# drop if nbrespat3b<18
# *Drop if didn't go this year or form is disqualified
# drop if firstyear==3
# drop if completed=="Disqualified" 
# 
# *Drop if no data on the variables used to weight the survey 
# *(dropped 34 for uspartyipf, 25 for age and 17 for virgin)
# drop if age==.
# drop if age<16
# drop if gender==.
# drop if virgin==.
# drop if uspartyipf==.
# 
# 
# tab1 early virgin nbburns2 gender agegr4 englishipf foreignipf uspartyipf votestatus,m
# gen filterbmorg1bfarrival=1
# replace filterbmorg1bfarrival=. if early==.|nbburns2==.|gender==.|agegr4==.|englishipf==.|foreignipf==.|uspartyipf==.|votestatus==.
# tab filterbmorg1bfarrival,m
# gen filterbmorg2bfdesire=filterbmorg1bfarrival
# replace filterbmorg2bfdesire=. if nbrespat4<=11
# gen filternerds=filterbmorg2bfdesire
# replace filternerds=. if nbrespat5<=10
# 
# *************************************
# ********************
# *Raking and trimming procedure 
# *for uspartyipf, multiple affiliations in random sample were considered here as independent
# *************************************
# 
# save "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFullMar2018.dta", replace
# *use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFullMar2018.dta"
# keep  id early nbburns3 gender agegr5 englishipf foreignipf uspartyipf votestatus filter*
# 
# *GLOBAL WEIGHTS with official peak population
# *early  65.31 34.69 (from xl sheet)
# *nbburns3 36.20 19.14 10.43 14.82 10.34 9.05
# *gender 57.97 40.41 1.62
# *agegr5 1.07 26.55 40.89 31.49
# *englishipf 22.51 77.49
# *foreignipf 76.53 23.47 
# *uspartyipf 30.01 36.22 3.81 2.88 1.24 1.25 24.60  (multiple counted as unaffiliated)
# *votestatus 29.47 7.78 62.75
# *Calculate weight
# 
# ipfweight early nbburns3 gender agegr5 englishipf foreignipf uspartyipf votestatus if filterbmorg1bfarrival==1, gen(weightbfarrival) val(65.31 34.69 36.20 19.14 10.43 14.82 10.34 9.05 57.97 40.41 1.62 1.07 26.55 40.89 31.49 22.51 77.49 76.53 23.47 30.01 36.22 3.81 2.88 1.24 1.25 24.60 29.47 7.78 62.75) maxit(21) tol(0.1) up(5) lo(0.20)
# ipfweight early nbburns3 gender agegr5 englishipf foreignipf uspartyipf votestatus if filterbmorg2bfdesire==1, gen(weightbfdesire) val(65.31 34.69 36.20 19.14 10.43 14.82 10.34 9.05 57.97 40.41 1.62 1.07 26.55 40.89 31.49 22.51 77.49 76.53 23.47 30.01 36.22 3.81 2.88 1.24 1.25 24.60 29.47 7.78 62.75) maxit(21) tol(0.1) up(5) lo(0.20)
# ipfweight early nbburns3 gender agegr5 englishipf foreignipf uspartyipf votestatus if filternerds==1, gen(weightnerds) val(65.31 34.69 36.20 19.14 10.43 14.82 10.34 9.05 57.97 40.41 1.62 1.07 26.55 40.89 31.49 22.51 77.49 76.53 23.47 30.01 36.22 3.81 2.88 1.24 1.25 24.60 29.47 7.78 62.75) maxit(21) tol(0.1) up(5) lo(0.20)
# 
# keep id weight*
# save "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Temp_for_trash.dta", replace
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFullMar2018.dta", replace
# merge 1:1 id using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Temp_for_trash.dta"
# drop _merge 
# drop filter*
# svyset id [pweight=weightbfarrival]
# save "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFullMar2018.dta", replace
# 
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFullMar2018.csv", comma replace  
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFullMar2018nolabels.csv", comma nolabel replace
# drop startdate- firstyear residenceother zipcode postalcode educother_qual language_TEXT native_qual ethnoother_qual politicalid_qual othersexlabel_qual religionotherChr religionother bminvolve_other_qual bminfoother_TEXT valued_other_qual princf_incl_qual- princf_immed_qual volunteerother_qual skillother_qual certifother_qual travelbrcother vehicletypeother bxbforother_qual ticketwhere_qual ticketcost_qual sortother_qual trashother_qual powerother_qual publicother_qual toother_qual notgoneother_qual nbrespat2- nbrespat5
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFullbutquali.csv", comma replace  
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFullbutqualinolabels.csv", comma nolabel replace
# 
# NEW OUTSHEET:May 2018 REQUEST. AARON & DV8
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFullMar2018.dta", replace
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFulltabMar2018.csv", replace  
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFulltabMar2018nolabels.csv", nolabel replace
# drop startdate- firstyear residenceother zipcode postalcode educother_qual language_TEXT native_qual ethnoother_qual politicalid_qual othersexlabel_qual religionotherChr religionother bminvolve_other_qual bminfoother_TEXT valued_other_qual princf_incl_qual- princf_immed_qual volunteerother_qual skillother_qual certifother_qual travelbrcother vehicletypeother bxbforother_qual ticketwhere_qual ticketcost_qual sortother_qual trashother_qual powerother_qual publicother_qual toother_qual notgoneother_qual nbrespat2- nbrespat5
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFulltabbutquali.csv", replace  
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFulltabbutqualinolabels.csv", nolabel replace
# 
# 
# 
# BEGINING OF REPORT
# 
# ***For report***
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFullMar2018.dta", replace
# *Drop qualitative or count variables
# drop startdate- firstyear residenceother zipcode postalcode educother_qual language_TEXT native_qual ethnoother_qual politicalid_qual othersexlabel_qual religionotherChr religionother bminvolve_other_qual bminfoother_TEXT valued_other_qual princf_incl_qual- princf_immed_qual volunteerother_qual skillother_qual certifother_qual travelbrcother vehicletypeother bxbforother_qual ticketwhere_qual ticketcost_qual sortother_qual trashother_qual powerother_qual publicother_qual toother_qual notgoneother_qual nbrespat2- nbrespat5
# *drop residenceother  educother_qual language_TEXT native_qual ethnoother_qual uspartyother religionotherChr religionother bminvolve_other_qual gathername1- ethostype4 bminfoother_TEXT valued_other_qual princf_incl_qual- princf_immed_qual volunteerother_qual skillother_qual certifother_qual 
# *drop travelbrcother flyother vehicletypeother bxbforother_qual bxbreccommendations ticketwhere_qual ticketcost_qual sortother_qual childsafeother_qual powerother_qual othersexlabel_qual artform_qual
# 
# capture log close
# log using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2017", replace
# svyset id [pweight=weightbfarrival]
# 
# *Variables used to weight the survey
# svy: prop virgin nbburns2 gender agegr5 englishipf foreignipf uspartyipf votestatus
# prop virgin nbburns2 gender agegr5 englishipf foreignipf uspartyipf votestatus
# 
# *Sociodemographics
# svy: mean age 
# svy: prop agegr agegr2 agegr3 agegr4 agegr5
# svy: prop gender
# svy: prop incomep
# svy: prop household
# svy: prop incomeh
# svy: prop incomep2
# svy: prop incomeh2
# svy: prop educ
# svy: prop techvocational_certif
# 
# svy: prop ethno white asian hispanic middleeastern native black 
# *svy: prop married
# *svy: prop openrelat
# svy: prop color
# svy: prop residence country foreignipf
# svy: prop state 
# svy: prop province
# svy: prop language english
# svy: prop virgin 
# svy: prop nbburns2 
# svy: prop timesincefirstburn2
# 
# *Politics
# svy: prop usvote
# svy: prop usparty if usparty!=0
# svy: prop uspartyipf
# svy: prop nbvotes voteyn 
# svy: prop votestatus 
# 
# *Sexuality, spirituality & religion
# svy: prop trans-intersex 
# svy: prop mono-othersexlabel
# 
# *Principles
# svy: prop princf_incl-princf_immed
# svy: prop princd_incl-princd_immed
# svy: prop prinimport
# svy: prop prinessent
# svy: prop princchange
# svy: prop princwork
# 
# *BM-related variables 
# svy: prop burnerid 
# svy: mean don_*
# 
# svyset id [pweight=weightbfdesire]
# 
# svy: prop arrival arrival2
# svy: prop leaving
# svy: prop early
# svy: prop lengthofstay
# svy: prop travelbrc
# svy: prop fly
# svy: prop nbvehicle2
# svy: prop nb012vehicle2
# svy: prop nb1317vehicle2
# svy: prop nb017vehicle
# svy: prop vehicletype
# *svy: mean milestotal
# *svy: mean milesnev
# *svy: mean mpg
# svy: prop ticketwhere
# svy: prop ticketcost
# svy: mean bmspending
# svy: prop bmspending
# svy: prop bmspendingcat
# svy: mean nvspendfuel- nvspendfun nvspendtotal
# svy: prop nvspendtotal2
# svy: prop parkvisit
# svy: prop sortwaste
# svy: prop sortburnable-sortother
# svy: prop trash*
# svy: prop nbcamp
# svy: prop nbfamily2
# svy: prop rv rv2
# svy: prop rv if rv!=0 & rv!=1
# svy: prop rvadults
# svy: prop broughtminor
# svy: prop childban
# svy: prop powerno powerbat powersol powerwind powervehic powercamp poweranot powergrid
# svy: prop vehicfueltype    
# *svy: mean hoursvehicgen
# svy: prop campfueltype
# svy: prop campgenoutput
# *svy: mean hourscampgen
# *svy: prop assignedcamp
# *svy: prop location*
# 
# *BXB
# svy: prop bxbtravel
# svy: prop bxbcamp 
# svy: prop bxbshuttle
# svy: prop bxbfor*
# svy: prop bxbprice
# svy: prop bxbexp 
# svy: prop bxbticketexp 
# 
# *Nerds' section
# svyset id [pweight=weightnerds]
# 
# svy: prop brcsafe
# svy: prop brcconnect
# svy: prop money
# svy: prop enjoy
# svy: prop intend
# svy: prop burnerfamily
# 
# svy: prop desirereli
# svy: prop attainreli
# svy: prop desireadv
# svy: prop attainadv
# svy: prop desiresocresp
# svy: prop attainsocresp
# svy: prop desireties
# svy: prop attainties
# svy: prop desireaccept
# svy: prop attainaccept
# svy: prop desirespc
# svy: prop attainspc
# svy: prop desireesth
# svy: prop attainesth
# svy: prop desireanx
# svy: prop attainanx
# svy: prop desireqol
# svy: prop attainqol
# svy: prop desirefree
# svy: prop attainfree
# svy: prop desirevalues
# svy: prop attainvalues
# svy: prop desireart
# svy: prop attainart
# svy: prop desireexpres
# svy: prop attainexpres
# svy: prop desirespi
# svy: prop attainspi
# svy: prop desirecoop
# svy: prop attaincoop
# svy: prop desirerecyc
# svy: prop attainrecyc
# svy: prop desirestew
# svy: prop attainstew
# svy: prop desireprotec
# svy: prop attainprotec
# svy: prop desireimpact
# svy: prop attainimpact
# svy: prop desirecommaesthe
# svy: prop attaincommaesthe
# svy: prop desireecotour
# svy: prop attainecotour
# svy: prop contribthink
# svy: prop contribgroup
# svy: prop contribnat
# svy: prop contribremote
# svy: prop contribdesert
# svy: prop contribfacilities
# svy: prop contribactivities
# svy: prop contribart
# svy: prop contribmeet
# svy: prop publiccamping- publicother
# 
# svy: prop reno- beatty 
# 
# translate "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2017.smcl" "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2017.log", linesize(255) translator(smcl2log) replace
# 
# BEGINING OF 2nd REPORT
# 
# ***For report***
#   use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFullMar2018.dta", replace
# *Drop qualitative or count variables
# drop startdate- firstyear residenceother zipcode postalcode educother_qual language_TEXT native_qual ethnoother_qual politicalid_qual othersexlabel_qual religionotherChr religionother bminvolve_other_qual bminfoother_TEXT valued_other_qual princf_incl_qual- princf_immed_qual volunteerother_qual skillother_qual certifother_qual travelbrcother vehicletypeother bxbforother_qual ticketwhere_qual ticketcost_qual sortother_qual trashother_qual powerother_qual publicother_qual toother_qual notgoneother_qual nbrespat2- nbrespat5
# 
# capture log close
# log using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2017", replace
# svyset id [pweight=weightbfarrival]
# 
# *Sexuality, spirituality & religion
# 
# svy: prop politicalid
# svy: prop sexattraction sexattraction2
# svy: prop sexorientation 
# svy: prop sexorientation if gender==0
# svy: prop sexorientation if gender==1
# svy: prop sexorientation if gender==2
# svy: prop trans genderqueer gendernonconforming genderquestioning twospirit intersex
# svy: prop lgbt
# svy: prop lgbt if gender==0
# svy: prop lgbt if gender==1
# svy: prop lgbt if gender==2
# svy: prop married
# svy: prop openrelat
# svy: prop mono- open_curious
# svy: prop polykink
# svy: prop spirituality
# svy: prop religion
# 
# *BM-related variables 
# svy: prop bmevents
# svy: prop bminvolve*
#   svy: prop bminfojrs          
# svy: prop bminfodl
# svy: prop bminfobmweb
# svy: prop bminfobmjournal
# svy: prop bminforegnew
# svy: prop bminforegweb
# svy: prop bminfobmir
# svy: prop bminfosmbm
# svy: prop bminfosmnot
# svy: prop bminfoeplaya
# svy: prop bminfowom
# 
# svy: prop valued*
#   svy: prop bmir*
#   svy: prop bmgr
# svy: prop bmprog*
#   svy: prop volunteerbrc- volunteerother 
# svy: prop volunteerinspired
# svy: prop skillcreation- skillother
# svy: prop skilluseful 
# svy: prop skillusefam-skillusebrc
# svy: prop certifosha-certiffiresafety
# svy: prop yearround
# 
# svyset id [pweight=weightbfdesire]
# 
# svy: prop assignedcamp
# svy: prop location*
#   
#   svyset id [pweight=weightnerds]
# 
# svy: prop intendbrd          
# svy: prop smilebrcfriend
# svy: prop smiledwfriend
# svy: prop smilebrccontrol
# svy: prop smiledwcontrol
# svy: prop smilebrchappy
# svy: prop smiledwhappy
# svy: prop emotionbrc
# svy: prop emotiondw
# svy: prop statusbrc
# svy: prop statusdw
# svy: prop artist
# 
# svy: prop toexpart-toother
# 
# svy: prop transfo
# svy: prop transfoextent
# svy: prop transfoexp     
# svy: prop transfodesire     
# svy: prop transfoper
# svy: prop longchange
# svy: prop specexp
# svy: prop specmoral
# svy: prop specexpect
# svy: prop specdesire
# svy: prop specglad
# svy: prop bestintentions
# svy: prop selfother
# svy: mean givetostranger
# svy: prop playdw 
# svy: prop newfriendsdw
# svy: prop notgonecost-notgoneother
# svy: prop notgonenoticketnb-notgonecostnb 
# svy: prop sampledgate-censusposts
# 
# translate "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2017.smcl" "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2017.log", linesize(255) translator(smcl2log) replace
# 
# XXX RELEASE OF THE DATA
# 
# *COMPLETE DB
# 
# 
# *COMPLETE DB WTOUT QUALI
# 
# 
# *SIMONE'S REQUEST (2017 BRC GEOMAPPING)
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFullMar2018.dta", replace
# drop residenceother  educother_qual language_TEXT native_qual ethnoother_qual uspartyother religionotherChr religionother bminvolve_other_qual bminfoother_TEXT valued_other_qual certifother_qual 
# drop travelbrcother flyother vehicletypeother bxbforother_qual bxbreccommendations ticketwhere_qual ticketcost_qual sortother_qual powerother_qual othersexlabel_qual
# drop politicalid_qual princf_incl_qual- princf_immed_qual volunteerother_qual skillother_qual trashother_qual publicother_qual toother_qual notgoneother_qual
# drop zipcode postalcode sex birth firstyear firstfill startdate completed enddate  educ_1- educ_6
# keep id gender burn2016-burn1986 residence incomep household incomeh language sexorientation-bminvolve_perfo bmir_brcair bmir_centercamp princf_incl-princf_immed princd_incl-prinessent volunteerbrc volunteerbmreg volunteerbwb burnerid arrival leaving travelbrc bmspending sortwaste-sortcompost trashcampserv-trashsomeone nbcamp rv nbfamily broughtminor address_letter address_hour locationattract-locationparties artist brcsafe brcconnect toexpart-tosatissomeone enjoy intend transfo specexp newfriendsdw virgin agegr-english ethno voteyn votestatus uspartyipf het-refusesexlabels lgbt early-nb017vehicle bmspendingcat nvspendtotal2 rv2 nbfamily2 weightbfarrival-weightnerds
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Census2017Geomapwtlabels.csv", comma replace  
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Census2017Geomapwtvalues.csv", comma nolabel replace
# 
# *MORGANISM
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFullMar2018.dta", replace
# drop residenceother  educother_qual language_TEXT native_qual ethnoother_qual uspartyother religionotherChr religionother bminvolve_other_qual bminfoother_TEXT valued_other_qual certifother_qual 
# drop travelbrcother flyother vehicletypeother bxbforother_qual bxbreccommendations ticketwhere_qual ticketcost_qual sortother_qual powerother_qual othersexlabel_qual
# drop politicalid_qual princf_incl_qual- princf_immed_qual volunteerother_qual skillother_qual trashother_qual publicother_qual toother_qual notgoneother_qual
# drop zipcode postalcode sex birth firstyear firstfill startdate completed enddate  educ_1- educ_6
# drop id burn2016- burn1986 asian- ethnoother bmevents- certiffiresafety yearround- don_other sortwaste- trashother nbfamily- childban assignedcamp- censusposts englishipf ethnocount bmirsourcescount bxbcount2 reno- beatty nbrespat2- nbrespat5
# save "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Census2017_transport.dta", replace
# 
# *Recreation
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Clean2017CensusFullMar2018.dta", replace
# drop residenceother  educother_qual language_TEXT native_qual ethnoother_qual uspartyother religionotherChr religionother bminvolve_other_qual bminfoother_TEXT valued_other_qual certifother_qual 
# drop travelbrcother flyother vehicletypeother bxbforother_qual bxbreccommendations ticketwhere_qual ticketcost_qual sortother_qual powerother_qual othersexlabel_qual
# drop politicalid_qual princf_incl_qual- princf_immed_qual volunteerother_qual skillother_qual trashother_qual publicother_qual toother_qual notgoneother_qual
# drop zipcode postalcode sex birth firstyear firstfill startdate completed enddate  educ_1- educ_6
# drop id burn2016- burn1986 asian- ethnoother color- spirituality bmevents- don_other sortwaste- trashother rvadults- locationidk arrival leaving fly- ticketcost nevadacities smilebrcfriend- toother polykink ethnocount transfo- censusposts englishipf province foreignipf rv nbcamp nbvotes- uspartyipf sexattraction2- early lengthofstay- bxbcount2 nbfamily2- longitude nbrespat2- nbrespat5 weightbfarrival weightbfdesire
# 
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Census2017Recreationwtlabels.csv", comma replace  
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2017/Census2017Recreationwtvalues.csv", comma nolabel replace
# 
# 
# xx
# 
# 
# *Clean miles & mpg (some numbers seem too big)
# replace milestotal= subinstr(milestotal,",","",4)
# replace milestotal= subinstr(milestotal,"miles","",4)
# replace milestotal= subinstr(milestotal," ","",10)
# destring milestotal, force replace
# replace milesnev= subinstr(milesnev,",","",4)
# replace milesnev= subinstr(milesnev,"miles","",4)
# replace milesnev= subinstr(milesnev," ","",10)
# destring milesnev, force replace
# recode milestotal milesnev (500000/999999999999999999=.)
# 
# destring mpgother, force replace
# recode mpgother (1000/999999999999=.)
# gen electricvehicle=mpg
# recode electricvehicle (2=1)(1=0) (3=0)
# lab val electricvehicle yn
# replace mpg=mpgother
# lab val mpg .
# drop mpgother
# 
# 
# 
# 
# xxxxxxxxxxxxxxxx
# 
# TO EXTRACT THE DATABASE FOR:
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/PonderationBM/Clean2012CensusFullFeb2015.dta", clear
# 
# - DV8 2018 REQUESTS
# capture log close
# log using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2018", replace
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg1]
# svy: prop agegr3
# 
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# 
# 
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# 
# 
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# svyset id [pweight=weight]
# 
# 
# 
# 
# - SCRIBBLE (SOCIO DIVERSITY + PLAY)
# 
# ***SOCIO DIVERSITY***
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# *Drop qualitative or count variables
# drop residenceother  educother_qual language_TEXT native_qual ethnoother_qual uspartyother religionotherChr religionother bminvolve_other_qual gathername1- ethostype4 bminfoother_TEXT valued_other_qual princf_incl_qual- princf_immed_qual volunteerother_qual skillother_qual certifother_qual 
# drop travelbrcother flyother vehicletypeother bxbforother_qual bxbreccommendations ticketwhere_qual ticketcost_qual sortother_qual childsafeother_qual powerother_qual othersexlabel_qual artform_qual  
# 
# keep residence zipcode incomep household incomeh educ age-agegr5 birth artist virgin nbburns2 bmspending- nvspendfun bmspendingcat nvspendtotal nvspendtotal2 weightbmorg2 
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Census2016Socioeconomic.csv", comma replace  
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Census2016Socioeconomic2.csv", comma nolabel replace
# ***PLAY***
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# *Drop qualitative or count variables
# drop residenceother  educother_qual language_TEXT native_qual ethnoother_qual uspartyother religionotherChr religionother bminvolve_other_qual gathername1- ethostype4 bminfoother_TEXT valued_other_qual princf_incl_qual- princf_immed_qual volunteerother_qual skillother_qual certifother_qual 
# drop bmirsourcescount memories_TEXT travelbrcother flyother vehicletypeother bxbforother_qual bxbreccommendations ticketwhere_qual ticketcost_qual sortother_qual childsafeother_qual powerother_qual othersexlabel_qual artform_qual  
# drop id-birth  zipcode postalcode bminfojrs-bmprogramsbmrn address_letter address_hour sampledgate-usedata latitude longitude nbrespat2-nbrespatend
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Census2016light.csv", comma replace  
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Census2016light2.csv", comma nolabel replace
# 
# 
# - DV8 2016 TRENDS REPORT REQUESTS
# capture log close
# log using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016", replace
# 
# *extract intersex % for 2013 & 2014
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# gen intersex=.
# replace intersex=0 if sex!=.
# replace intersex=1 if sex==2|sex==3
# svy: prop intersex
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# svyset id [pweight=weight]
# gen intersex=.
# replace intersex=0 if sex!=.
# replace intersex=1 if sex==2|sex==3
# svy: prop intersex
# 
# *personal & household income wt fewer categories (2013-2016)
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# recode incomep (1 2 3 4=0)(5 6=1)(7 8=2)(9 10=3)(11=4), gen(incomep5cat)
# recode incomeh (1 2 3 4=0)(5 6=1)(7 8=2)(9 10=3)(11=4), gen(incomeh5cat)
# lab def inc5cat 0"_0_24999US" 1"_25k_49999US" 2"_50k_99999US" 3"_100k_299999US" 4"_300kUS_or_more"
# lab val incomep5cat incomeh5cat inc5cat
# svyset id [pweight=weightbmorg1]
# svy: prop incomep5cat
# svy: prop incomeh5cat
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# recode incomep (1 2 3 4=0)(5 6=1)(7 8=2)(9 10=3)(11=4), gen(incomep5cat)
# recode incomeh (1 2 3 4=0)(5 6=1)(7 8=2)(9 10=3)(11=4), gen(incomeh5cat)
# lab def inc5cat 0"_0_24999US" 1"_25k_49999US" 2"_50k_99999US" 3"_100k_299999US" 4"_300kUS_or_more"
# lab val incomep5cat incomeh5cat inc5cat
# svyset id [pweight=weightbmorg1]
# svy: prop incomep5cat
# svy: prop incomeh5cat
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# recode income (1 2 3 4=0)(5 6=1)(7 8=2)(9 10=3)(11=4), gen(income5cat)
# lab def inc5cat 0"_0_24999US" 1"_25k_49999US" 2"_50k_99999US" 3"_100k_299999US" 4"_300kUS_or_more"
# lab val income5cat inc5cat
# svyset id [pweight=weightbmorg]
# svy: prop income5cat
# svy: prop income5cat if primaryincome==0
# svy: prop income5cat if primaryincome==1
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# recode income (1 2 3 4=0)(5 6=1)(7 8=2)(9 10=3)(11=4), gen(income5cat)
# lab def inc5cat 0"_0_24999US" 1"_25k_49999US" 2"_50k_99999US" 3"_100k_299999US" 4"_300kUS_or_more"
# lab val income5cat inc5cat
# svyset id [pweight=weight]
# svy: prop income5cat
# svy: prop income5cat if primaryincome==0
# svy: prop income5cat if primaryincome==1
# 
# *countries: 2016 does not match previous years. Can I make it match? It does match. The new labels are more precise
# 
# *timesincefirstburn2 for 2014 is missing
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# svy: prop timesincefirstburn2
# 
# *SO for 2013 and 2014: Do as 2015/16, i.e., total, men, women and fluid.
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# svy: prop sexattraction sexattraction2
# svy: prop sexorientation 
# svy: prop sexorientation if gender==0
# svy: prop sexorientation if gender==1
# svy: prop sexorientation if gender==2
# svy: prop lgbt
# svy: prop lgbt if gender==0
# svy: prop lgbt if gender==1
# svy: prop lgbt if gender==2
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# svyset id [pweight=weight]
# svy: prop sexattraction sexattraction2
# svy: prop sexorientation 
# svy: prop sexorientation if gender==0
# svy: prop sexorientation if gender==1
# svy: prop sexorientation if gender==2
# svy: prop lgbt
# svy: prop lgbt if gender==0
# svy: prop lgbt if gender==1
# svy: prop lgbt if gender==2
# 
# *CountriesVisited: Extract info for 2014
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# svy: prop countriesvisited
# 
# *Valued_other is missing from 2014. Extract it.
# svy: prop valuedother
# 
# *BMIR is messy. 2016 and 2013 are different from 2014/15. What should we do?
# *FM radio: 2013-16
# *Speakers: 2014/16
# *Mobile: 2013/16
# *Online: 2013*/15
# *No idea: 2014/16
# *Knew but did not: 2014/16
# *BRC ratings (FM+Mobile): 2013/16
# *Yearly ratings (1-(No idea+Knew but did not): 2013*/16
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg1]
# gen bmir_brcratings=bmir_brcair+bmir_travelmobile
# recode bmir_brcratings (2=1)
# gen bmir_yearlyratings=bmir_didntknow+bmir_no
# recode bmir_yearlyratings (0=1)(1=0)
# lab def yn2 0"no" 1"yes"
# lab val bmir_brcratings bmir_yearlyratings yn2
# svy: prop bmir_brcair
# svy: prop bmir_centercamp
# svy: prop bmir_travelmobile
# 
# svy: prop bmir_didntknow
# svy: prop bmir_no
# svy: prop bmir_brcratings
# svy: prop bmir_yearlyratings
# 
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg1]
# gen bmir_brcratings=bmir_brcair+bmir_travelmobile
# recode bmir_brcratings (2=1)
# gen bmir_yearlyratings=bmir_didntknow+bmir_no
# recode bmir_yearlyratings (0=1)(1=0)
# lab def yn2 0"no" 1"yes"
# lab val bmir_brcratings bmir_yearlyratings yn2
# svy: prop bmir_brcair
# svy: prop bmir_centercamp
# svy: prop bmir_travelmobile
# svy: prop bmir_online
# svy: prop bmir_didntknow
# svy: prop bmir_no
# svy: prop bmir_brcratings
# svy: prop bmir_yearlyratings
# 
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# gen bmir_brcratings=bmir_brcair+bmir_travelmobile
# recode bmir_brcratings (2=1)
# gen bmir_yearlyratings=bmir_didntknow+bmir_no
# recode bmir_yearlyratings (0=1)(1=0)
# lab def yn2 0"no" 1"yes"
# lab val bmir_brcratings bmir_yearlyratings yn2
# svy: prop bmir_brcair
# svy: prop bmir_centercamp
# svy: prop bmir_travelmobile
# svy: prop bmir_online
# svy: prop bmir_didntknow
# svy: prop bmir_no
# svy: prop bmir_brcratings
# svy: prop bmir_yearlyratings
# 
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# svyset id [pweight=weight]
# rename bmir_travel bmir_travelmobile
# rename bmir_bm bmir_brcair
# gen bmir_online=bmir_yearround+bmir_preevent
# recode bmir_online (2=1)
# gen bmir_brcratings=bmir_brcair+bmir_travelmobile
# recode bmir_brcratings (2=1)
# gen bmir_yearlyratings=bmir_brcratings+bmir_online
# recode bmir_yearlyratings (2=1)
# lab def yn2 0"no" 1"yes"
# lab val bmir_brcratings bmir_online bmir_yearlyratings yn2
# svy: prop bmir_brcair
# svy: prop bmir_travelmobile
# svy: prop bmir_online
# 
# svy: prop bmir_brcratings
# svy: prop bmir_yearlyratings
# 
# *Integrate tech/voc into formal educ from 2013 to 2016
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg1]
# gen educ2=educ
# recode educ2 (2=3)(3=4)(4=5)(5=6)(6=7)
# replace educ2=2 if techvocational_certif==1 & (educ==0|educ==1|educ==6)
# label def educ2 0"None" 1"High_school" 2"Technical_or_Vocational_certif" 3"Some_college" 4"Assoc_degree" 5"Bac_degree" 6"Grad_degree" 7"Only_other"
# label val educ2 educ2
# svy: prop educ2 
# svy: prop techvocational_certif 
# svy: prop educ
# 
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg1]
# gen educ2=educ
# recode educ2 (2=3)(3=4)(4=5)(5=6)(6=7)
# replace educ2=2 if techvocational_certif==1 & (educ==0|educ==1|educ==6)
# label def educ2 0"None" 1"High_school" 2"Technical_or_Vocational_certif" 3"Some_college" 4"Assoc_degree" 5"Bac_degree" 6"Grad_degree" 7"Only_other"
# label val educ2 educ2
# svy: prop educ2 
# svy: prop techvocational_certif 
# svy: prop educ
# 
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# gen educ2=educ
# recode educ2 (2=3)(3=4)(4=5)(5=6)(6=7)
# replace educ2=2 if techvocational_certif==1 & (educ==0|educ==1|educ==6)
# label def educ2 0"None" 1"High_school" 2"Technical_or_Vocational_certif" 3"Some_college" 4"Assoc_degree" 5"Bac_degree" 6"Grad_degree" 7"Only_other"
# label val educ2 educ2
# svy: prop educ2 
# svy: prop techvocational_certif 
# svy: prop educ
# 
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# svyset id [pweight=weight]
# gen educ2=educ
# recode educ2 (2=3)(3=4)(4=5)(5=6)(6=7)
# replace educ2=2 if techvocational_certif==1 & (educ==0|educ==1|educ==6)
# label def educ2 0"None" 1"High_school" 2"Technical_or_Vocational_certif" 3"Some_college" 4"Assoc_degree" 5"Bac_degree" 6"Grad_degree" 7"Only_other"
# label val educ2 educ2
# svy: prop educ2 
# svy: prop techvocational_certif 
# svy: prop educ
# 
# translate "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.smcl" "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.log", linesize(255) translator(smcl2log) replace
# 
# TO EXTRACT THE DATABASE FOR:
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg1]
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg1]
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# svyset id [pweight=weight]
# 
# - DV8 2016 TRENDS REPORT REQUESTS (II)
# capture log close
# log using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016", replace
# 
# *median personal income AND age for 2013-2016, and the median household income for 2015-2016 (see xls for results)
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg1]
# svy: prop incomep
# svy: prop incomeh
# svy: prop age
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg1]
# svy: prop incomep
# svy: prop incomeh
# svy: prop age
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# svy: prop income
# svy: prop age
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# svyset id [pweight=weight]
# svy: prop income
# svy: prop age
# 
# *For the "if you had $100 to donate" question, are the numbers in the Census report the average dollar value?
# *YES
# 
# *Can we get the average dollar value suggested for a GLC ticket? The percentage isn't as useful, here
# *That's what I gave you but it's high due to some very high values. I pt the percentiles (including median) in the excel
# 
# *For "arrival" and "leaving" we need categories that match up. Can you help with this
# 
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg2]
# recode arrival (1/3=3)(13/16=13), gen(arrival2)
# recode leaving (14/16=14), gen(leaving2)
# lab val arrival2 leaving2 date
# svy: prop arrival2 arrival
# svy: prop leaving2 leaving
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg2]
# recode arrival (1/3=3)(13/16=13), gen(arrival2)
# recode leaving (1/5=5)(14/16=14), gen(leaving2)
# lab val arrival2 leaving2 date
# svy: prop arrival2 arrival
# svy: prop leaving2 leaving
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# recode arrival (11/14=11), gen(arrival2)
# recode leaving (1/3=3)(12/14=12), gen(leaving2)
# lab val arrival2 leaving2 date
# svy: prop arrival2 arrival
# svy: prop leaving2 leaving
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# svyset id [pweight=weight]
# recode arrival (9/10=9), gen(arrival2)
# lab val arrival2 date
# svy: prop arrival2 arrival
# svy: prop leaving
# 
# 
# *"nbvehicle": 2015 and 2016 both have "NA" categories, but in those two years we only asked the question if the respondent selected "Gate in a vehicle" or "Point 1 in a vehicle." 2013 and 2014 we asked the question of everyone, and there is no N/A category. What's the best way to compare these years to each other?
# *nbvehicleminors: some of the 2015 datasets have a NA category while others don't, and none of the other years do. Again, in 2015-2016 we limited these questions to people who reported coming in from a vehicle, which we didn't in 2013-14. How best to compare these datasets?
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg2]
# recode nbvehicle2 (6/9=5), gen(nbvehicle3)
# lab def nbvehicle3 5"_5_or_more"
# lab val nbvehicle3 nbvehicle3
# svy: prop nbvehicle2 if travelbrc==1
# svy: prop nbvehicle3 if travelbrc==1
# svy: prop nb012vehicle2 if travelbrc==1
# svy: prop nb1317vehicle2 if travelbrc==1
# svy: prop nb017vehicle if travelbrc==1  
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg2]
# recode nbvehicle2 (6/9=5), gen(nbvehicle3)
# lab def nbvehicle3 5"_5_or_more"
# lab val nbvehicle3 nbvehicle3
# svy: prop nbvehicle2 if travelbrc==1
# svy: prop nbvehicle3 if travelbrc==1
# svy: prop nb012vehicle2 if travelbrc==1
# svy: prop nb1317vehicle2 if travelbrc==1
# svy: prop nb017vehicle if travelbrc==1
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# recode nbvehicle2 (6/9=5), gen(nbvehicle3)
# lab def nbvehicle3 5"_5_or_more"
# lab val nbvehicle3 nbvehicle3
# svy: prop nbvehicle2 if travelbrc==1
# svy: prop nbvehicle3 if travelbrc==1
# svy: prop nb012vehicle2 if travelbrc==1
# svy: prop nb1317vehicle2 if travelbrc==1
# svy: prop nb017vehicle if travelbrc==1
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# svyset id [pweight=weight]
# recode nbvehicle2 (6/9=5), gen(nbvehicle3)
# lab def nbvehicle3 5"_5_or_more"
# lab val nbvehicle3 nbvehicle3
# svy: prop nbvehicle2 if travelbrc==1
# svy: prop nbvehicle3 if travelbrc==1
# svy: prop nb012vehicle2 if travelbrc==1
# svy: prop nb1317vehicle2 if travelbrc==1
# svy: prop nb017vehicle if travelbrc==1
# 
# *how to deal with "ticketwhere" - it's a question people will definitely want to compare year to year, but we've altered options frequently!
# *I made 2015 and 2016 comparable by excluding IDK in 2015 and collapsing no tickets and kids ticket in 2016
# *I also made 2014 to 2016 comparable by collapsing the three BM categories in 2015 and 2016 into one BM category and excluding IDK from 2014 and 2015
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg2]
# recode ticketwhere (10=11)
# recode ticketwhere (1/3=1), gen(ticketwhere2)
# lab val ticketwhere2 ticketwhere
# svy: prop ticketwhere
# svy: prop ticketwhere2
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg2]
# recode ticketwhere (1/3=1), gen(ticketwhere2)
# lab val ticketwhere2 ticketwhere
# svy: prop ticketwhere if ticketwhere!=8
# svy: prop ticketwhere2 if ticketwhere!=8
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# svy: prop ticketwhere if ticketwhere!=6
# 
# *There's a "bmspending" value in the 2016 and 2015 reports that don't seem to be reporting percentages. Can you clarify what it is and, if possible, provide comparable data from past years?
# *it's the average bmspending in USD. However, it is a big number due to some very big values. Use the bmspending cat instead.
# *"bmspendingcat" is in the 2016 and 2014 report, but missing from 2015. Can we get that data?
#   use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg2]
# svy: prop bmspendingcat
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg2]
# svy: prop bmspendingcat
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# svy: prop bmspending
# 
# *"nbfamily" (or "nbfamily2") sometimes includes a 0 value and sometimes doesn't, which drastically changes the math! Can we get the 2016 breakdown for 0, 1, 2, 3, 4+ please?
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg2]
# svy: prop nbfamily2
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg2]
# svy: prop nbfamily2
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# svy: prop nbfamily2
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# svyset id [pweight=weight]
# svy: prop nbfamily2
# 
# *"rv" - the 2015 and 2016 surveys have Yes-Pumped, Yes-IDKPumped, Yes-NotPumped, No, and IDK as options. the 2013 and 2014 surveys have Yes, No, and NotSure. If possible, I'd love to have: (a) 2013-2016 Yes, No, and IDK; (b)2015-2016 Pumped, IDKPumped, and NotPumped for the "Yes" respondents
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg2]
# recode rv (2/4=2), gen(rv2)
# lab def rv2 0"no" 1"not_sure" 2"yes"
# lab val rv2 rv2 
# svy: prop rv if rv2==2
# svy: prop rv2
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg2]
# recode rv (2/4=2), gen(rv2)
# lab def rv2 0"no" 1"not_sure" 2"yes"
# lab val rv2 rv2 
# svy: prop rv if rv2==2
# svy: prop rv2
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# svy: prop rv
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# svyset id [pweight=weight]
# svy: prop rv
# 
# *For the question about power, none of the reports listed the data for respondents who selected "Other." Since this was a "select all that applies" question I don't think this is a problem, but I wanted to double-check. If it is a problem, we'll need that data for 2013-2016.
# *It's not a problem. I didn't report the other info because it's hard to interpret without looking at the open ended answer. 
# 
# *For "bxbtravel" 2015 and 2016 show a small number of people for the variable "BRCtoSF" but this variable does not exist in the 2014 report. Can I simply skip that variable? Or did no one take that route in 2014?
# *The category existed in 2014, but no one checked it. 
# 
# 
# *For "bxbshuttle" the data looks really odd, and variables were sometimes reversed in the reports. Could you glance at the BxB slide at some point and just double-check it against the raw data?
# *The results are ok. There was an increase in the use of the shuttle. 
# 
# 
# *"bxbcamp" is missing data - 2014 is missing "yes but would not camp there again," 2015 is missing "idk." Can we get these additional variables?
# *missing data are due to no one checking that category. 
# 
# 
# *"bxbforother" is missing from the 2015 and 2016 reports, but 25% of 2014 respondents selected it, so I'm curious what the 2015 and 2016 results were like
# *The results are below. I didn't report it because without the qualitative data, it only means that they had something extra to say. I wouldn't report it but you can do it if you prefer. 
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg2]
# svy: prop bxbforother
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg2]
# svy: prop bxbforother
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# svy: prop bxbforother
# 
# *"bxbexp" is missing a variable - 2016 needs "terrible" and "9"
# *When a value is missing, it is generally because nobody checked that value. And that's what happened here. You can thus replace the missing categories with a zero and no CI 
# *However, the scale was incorrectly coded for 2015 in my first attempt, so here are the results in case I sent you the miscoded results
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg2]
# svy: prop bxbexp
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg2]
# svy: prop bxbexp
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# svy: prop bxbexp
# 
# translate "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.smcl" "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.log", linesize(255) translator(smcl2log) replace
# 
# - DV8 2016 TRENDS REPORT REQUESTS (III) States
# capture log close
# log using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016", replace
# 
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg1]
# encode state, generate(state2)
# svy: prop residence
# svy: prop residence if residence==1|residence==2|residence==3
# svy: prop state2 if residence==3
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg1]
# encode state, generate(state2)
# svy: prop residence
# svy: prop residence if residence==1|residence==2|residence==3
# svy: prop state2 if residence==3
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# encode state, generate(state2)
# svy: prop residence
# svy: prop residence if residence==1|residence==2|residence==3
# svy: prop state2 if residence==3
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# svyset id [pweight=weight]
# encode state, generate(state2)
# svy: prop residence
# svy: prop residence if residence==1|residence==2|residence==3
# svy: prop state2 if residence==3
# 
# translate "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.smcl" "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.log", linesize(255) translator(smcl2log) replace
# 
# - DV8 2016 TRENDS REPORT REQUESTS (V) BMspending
# capture log close
# log using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016", replace
# 
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg2]
# svy: prop bmspending
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg2]
# svy: prop bmspending
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# svy: prop bmspending
# 
# translate "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.smcl" "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.log", linesize(255) translator(smcl2log) replace
# 
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg2]
# svy: prop ticketwhere
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg2]
# svy: prop ticketwhere
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# svy: prop ticketwhere
# 
# - DV8 2016 TRENDS REPORT REQUESTS (VI) 2014
# capture log close
# log using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016", replace
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightnerds]
# svy: prop artist
# svy: prop artform
# svy: prop paidartist
# svy: prop enjoy
# svy: prop intend
# svy: prop burnerfamily
# svy: prop brchome
# svy: prop memories
# svy: prop transfo
# svy: prop gatheringyn
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightnerds]
# svy: prop playdw
# svy: prop gatheryn
# 
# translate "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.smcl" "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.log", linesize(255) translator(smcl2log) replace
# 
# - DV8 2016 TRENDS REPORT REQUESTS (VII) language(other)
# capture log close
# log using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016", replace
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg1]
# svy: prop language
# lincom 1-(English+Chinese+French+German+Hebrew+Italian+Russian+Spanish)
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg1]
# svy: prop language
# lincom 1-(English+Chinese+French+German+Hebrew+Italian+Russian+Spanish)
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# svy: prop language
# lincom 1-(English+Chinese+French+German+Hebrew+Italian+Russian+Spanish)
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2013CensusFullJan2014.dta", replace
# svyset id [pweight=weight]
# svy: prop language
# lincom 1-(English+Chinese+French+German+Hebrew+Italian+Russian+Spanish)
# translate "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.smcl" "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.log", linesize(255) translator(smcl2log) replace
# 
# - DV8 for Comms: Netherlands/Europe. Residence & Income (perso/household)
# capture log close
# log using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016", replace
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# svyset id [pweight=weightbmorg1]
# gen netherlands=.
# replace netherlands=0 if country!=.
# replace netherlands=1 if residenceother=="Netherlands"
# svy: prop country
# svy: prop country if country!=0
# svy: prop netherlands if country==4
# svy: prop netherlands if country!=.
# svy: prop incomep if country==4
# lincom _50000_74999US+_75000_99999US
# lincom _100k_149999US+_150k_299999US+_300kUS_or_more
# svy: prop incomeh if country==4
# lincom _50000_74999US+_75000_99999US
# lincom _100k_149999US+_150k_299999US+_300kUS_or_more
# svy: reg incomep netherlands if country==4
# svy: reg incomeh netherlands if country==4
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg1]
# gen netherlands=.
# replace netherlands=0 if country!=.
# replace netherlands=1 if residenceother=="Netherlands"
# svy: prop country
# svy: prop country if country!=0
# svy: prop netherlands if country==4
# svy: prop netherlands if country!=.
# svy: prop incomep if country==4
# lincom _50000_74999US+_75000_99999US
# lincom _100k_149999US+_150k_299999US+_300kUS_or_more
# svy: reg incomep netherlands if country==4
# svy: prop incomeh if country==4
# lincom _50000_74999US+_75000_99999US
# lincom _100k_149999US+_150k_299999US+_300kUS_or_more
# svy: reg incomeh netherlands if country==4
# svy: prop incomeh if country==4 & netherlands==1
# lincom _50000_74999US+_75000_99999US
# lincom _100k_149999US+_150k_299999US
# svy: prop incomeh if country==4 & netherlands==0
# lincom _50000_74999US+_75000_99999US
# lincom _100k_149999US+_150k_299999US+_300kUS_or_more
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Clean2014CensusFullMarch2015.dta", replace
# svyset id [pweight=weightbmorg]
# gen netherlands=.
# replace netherlands=0 if country!=.
# replace netherlands=1 if residenceother=="Netherlands"
# svy: prop country
# svy: prop country if country!=0
# svy: prop netherlands if country==4
# svy: prop netherlands if country!=.
# svy: prop income if country==4
# lincom _50000_74999US+_75000_99999US
# lincom _100k_149999US+_150k_299999US
# svy: reg income netherlands if country==4
# svy: prop income if country==4 & netherlands==1
# lincom _50000_74999US+_75000_99999US
# lincom _100k_149999US+_150k_299999US
# svy: prop income if country==4 & netherlands==0
# lincom _50000_74999US+_75000_99999US
# lincom _100k_149999US+_150k_299999US
# translate "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.smcl" "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.log", linesize(255) translator(smcl2log) replace
# 
# 
# RELEASE FOR MOLLY AND DANIEL (TRANSFORMATION GROUP) in csv
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# drop residenceother  educother_qual language_TEXT native_qual ethnoother_qual uspartyother religionotherChr religionother bminvolve_other_qual gathername1- ethostype4 bminfoother_TEXT valued_other_qual certifother_qual 
# drop travelbrcother flyother vehicletypeother bxbforother_qual bxbreccommendations ticketwhere_qual ticketcost_qual sortother_qual childsafeother_qual powerother_qual othersexlabel_qual artform_qual
# keep id gender-residence income* techvocational_certif- beauty_certif language- black  color- religion gatheryn princf_incl- skilluseful burnerid toexpart- tosatissomeone enjoy- brchome transfo- givetostranger agegr- agegr5 nbburns2 foreignipf educ english ethno voteyn votestatus sexattraction2- refusesexlabels weight*
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Census2016Transfowtlabels.csv", comma replace  
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Census2016Transfowtvalues.csv", comma nolabel replace
# 
# TO EXTRACT THE DATABASE FOR:
# 
# RELEASE FOR SIMONE (BRC GEOMAPPING) in csv
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# drop residenceother  educother_qual language_TEXT native_qual ethnoother_qual uspartyother religionotherChr religionother bminvolve_other_qual gathername1- ethostype4 bminfoother_TEXT valued_other_qual certifother_qual 
# drop travelbrcother flyother vehicletypeother bxbforother_qual bxbreccommendations ticketwhere_qual ticketcost_qual sortother_qual childsafeother_qual powerother_qual othersexlabel_qual artform_qual
# drop zipcode postalcode sex birth firstyear firstfill reference completed enddate  educ_1- educ_6
# keep id gender residence incomep household incomeh language sexorientation-bminvolve_perfo princf_incl- princf_immed princd_incl- prinessent sortwaste- sortcompost trashcampserv- trashbxb gatheryn countriesvisited bmir_brcair bmir_centercamp volunteerbrc volunteerbmreg volunteerbwb burnerid arrival leaving travelbrc bmspending nbcamp rv broughtminor nbfamily address_letter address_hour locationattract-locationparties mono-open_curious artist artform brcsafe brcfree brcconnect toexpart-tosatissomeone enjoy-memories transfo specexp newfriendsdw virgin agegr-  english ethno voteyn votestatus uspartyipf het- refusesexlabels early- nb017vehicle bmspendingcat- lgbt weightbmorg1- weightnerds
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Census2016Geomapwtlabels.csv", comma replace  
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Census2016Geomapwtvalues.csv", comma nolabel replace
# 
# RELEASE FOR THE TWIN INDEX APP (MU) AND THE INDEX OF UNIQUENESS
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# keep id gender trans genderqueer gendernonconforming genderquestioning twospirit residence language usparty sexattraction sexorientation married openrelat spirituality religion countriesvisited milestotal bmspending rv mono poly kink swinger queer artist artform age agegr agegr2 agegr3 agegr4 agegr5 nbburns nbburns2 nbburns3 nbburns4 nbburns5 timesincefirstburn timesincefirstburn2 country foreignipf educ english englishipf ethno uspartyipf sexattraction2 bmspendingcat polykink lgbt state province weightbmorg1 weightbmorg2 weightnerds
# *To calculate cumulative percentiles
# capture log close
# log using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016", replace
# gen bmspending50=round(bmspending,50)
# gen milestotal50=round(milestotal,50)
# 
# RELEASE FOR SABRINA (KINK PROJECT)
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusFullDec2015.dta", replace
# svyset id [pweight=weightbmorg1]
# drop startdate- birth residenceother zipcode postalcode educ_1- educother_qual language_TEXT ethnoother_qual uspartyother religionother bminvolve_other_qual gathername1- ethosname4 bminfojrs- bmprogramsbmrn yearround- glcpublic travelbrc_TEXT fly_TEXT vehicletype_qual milestotal- nvspendfun powerno- address_hour othersexlabel_qual artform_qual toother_qual nottoother_qual backtoother_qual memories_TEXT transfoother_qual LocationLatitude LocationLongitude state province latitude longitude nbrespat2 nbrespat3 nbrespatend
# *Create sub-sample to analyse kink ID. 
# drop if weightnerds==. | polykink==. | trans==. | gaylesb==.
# 
# save "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2015/Clean2015CensusDec2015forSabrina.dta",replace
# 
# 
# svyset id [pweight=weightbmorg1]
# svy: prop age
# svy: prop countriesvisited
# svy: prop nbburns
# svy: prop timesincefirstburn
# svyset id [pweight=weightbmorg2]
# svy: prop milestotal50
# svy: prop bmspending50 
# translate "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.smcl" "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Analyses/Sorties/CensusReport_2016.log", linesize(255) translator(smcl2log) replace
# *DATASET FOR MU - FIRST VERSION TO TEST (n=6668)
# *Variables should have few categories, especially with small %
# *A maximum of 5(?) variables should be used/filtered at the same time to avoid empty searches
# *tab1  language usparty sexattraction sexorientation spirituality religion ,m
# keep gender agegr3 agegr4 nbburns2 nbburns3 timesincefirstburn2 residence married openrelat poly countriesvisited artist foreignipf englishipf lgbt weightbmorg2
# drop if weightbmorg2==.
# drop if residence==.| openrelat==.| married==.| poly==.| countriesvisited==.| artist==.| lgbt==.
# replace weightbmorg2=weightbmorg2/0.9995165
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Census2016TwinIndex_Labels.csv", comma replace  
# outsheet using "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Census2016TwinIndex_Numeric.csv", comma nolabel replace
# 
# REQUEST TO CALCULATE AVERAGE LENGTH OF STAY AT BRC IN 2016
# use "/Users/dbprevost/ownCloud/Recherche/Projets/BM/Census_Data/Online2016/Clean2016CensusFullNov2016.dta", replace
# *Create length of stay
# gen lengthofstay=leaving-arrival+1
# replace lengthofstay=. if leaving==5 | arrival==15 | arrival==16
# svyset id [pweight=weightbmorg1]
# svy: prop lengthofstay
# svy: mean lengthofstay
# svy: prop lengthofstay if virgin==1
# svy: mean lengthofstay if virgin==1
# svy: prop lengthofstay if virgin==0
# svy: mean lengthofstay if virgin==0
# 
# 
# *Requests by DV8
# svy: prop sex
# svy: prop sex if gender==0
# svy: prop sex if gender==1
# svy: prop sex if gender==2
# egen genderdiversity=anycount(trans-twospirit), v(1)
# replace genderdiversity=. if trans==.
# recode genderdiversity (1/6=1)
# lab val genderdiversity yn
# 
# 
# 
# 
