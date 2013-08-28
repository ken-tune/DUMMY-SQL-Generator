module namespace bespoke = "http://marklogic.com/SYTYCD/bespoke-generation";

import module namespace generate-lib = "http://marklogic.com/SYTYCD/generate-lib" at "/generate-lib.xqy";
import module namespace interest-rates = "http://marklogic.com/SYTYCD/bespoke-generation/interest-rates" at "/interest-rates.xqy";

declare function add-one-year($date-string as xs:string) as xs:string{
    let $date := date-from-string($date-string)
    return
    format-date($date + xs:yearMonthDuration("P1Y") - xs:dayTimeDuration("P1D"))
};

(: Here the function has to conform to a specific signature :)
declare function dateLastYear($string as xs:string){
    let $date := fn:current-date() - (xdmp:random(364) + 1) * xs:dayTimeDuration("P1D")
    return
    format-date($date)
};

(: Here the function has to conform to a specific signature :)
declare function dateLastThirtyYears($string as xs:string){
    let $date := fn:current-date() - xdmp:random(30 * 365)  * xs:dayTimeDuration("P1D")
    return
    format-date($date)
};

declare function mortgageEndDate($string as xs:string){
    let $term := xs:int(generate-lib:random-from-weighted-random("20:1,25:3,30:6"))
    let $date := date-from-string($string)
    let $new-date := $date + xs:dayTimeDuration("P1D") * 365 * $term
    return
    format-date($new-date)
};

declare function interestRate($date-string as xs:string) as xs:string{
    let $date := date-from-string($date-string)
    let $year := fn:year-from-date($date)
    let $recent-year := fn:year-from-date(fn:current-date()) - 7 
    let $rate := fn:min((map:get($interest-rates:interest-rate-map,xs:string($year)),map:get($interest-rates:interest-rate-map,xs:string($recent-year))))
    return
    xs:string($rate + (xdmp:random(20) div 10))
};


declare function create-sort-codes($schema as element(root))
{
    let $branch-count := xs:int($schema/table[table-name = "BRANCH"]/@rows)
    let $string := fn:string-join((
        "SortCode",
        for $count in (1 to $branch-count)
        return
        "74"||generate-lib:random-from-pattern("dddd")
        ),$generate-lib:LF
    )
    return
    xdmp:document-insert("/sort-codes.csv",text{$string})
};

declare private function format-date($date as xs:date) as xs:string{
    fn:day-from-date($date)||"/"||fn:month-from-date($date)||"/"||fn:year-from-date($date)
};

declare private function date-from-string($date-string as xs:string) as xs:date{
    let $parts := fn:tokenize($date-string,"/")
    let $parts := for $part in xs:int($parts) return if($part > 9) then xs:string($part) else "0"||$part 
    return
    xs:date(fn:string-join(fn:reverse($parts),"-"))
};