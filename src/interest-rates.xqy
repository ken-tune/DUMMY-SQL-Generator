module namespace interest-rates = "http://marklogic.com/SYTYCD/bespoke-generation/interest-rates";

declare variable $interest-rate-map := interest-rate-map();

declare function interest-rate-map(){
    let $map := map:map()
    let $null := (
            map:put($map,"1983",11),
            map:put($map,"1984",9.06),
            map:put($map,"1985",13.88),
            map:put($map,"1986",12.38),
            map:put($map,"1987",10.88),
            map:put($map,"1988",8.38),
            map:put($map,"1989",12.88),
            map:put($map,"1990",14.79),
            map:put($map,"1991",13.88),
            map:put($map,"1992",10.38),
            map:put($map,"1993",5.88),
            map:put($map,"1994",5.38),
            map:put($map,"1995",6.13),
            map:put($map,"1996",6.13),
            map:put($map,"1997",5.94),
            map:put($map,"1998",7.25),
            map:put($map,"1999",6),
            map:put($map,"2000",5.75),
            map:put($map,"2001",6),
            map:put($map,"2002",4),
            map:put($map,"2003",4),
            map:put($map,"2004",3.75),
            map:put($map,"2005",4.75),
            map:put($map,"2006",4.5),
            map:put($map,"2007",5.25),
            map:put($map,"2008",5.5),
            map:put($map,"2009",1.5),
            map:put($map,"2010",0.5),
            map:put($map,"2011",0.5),
            map:put($map,"2012",0.5),
            map:put($map,"2013",0.5))
    return
    $map
};
