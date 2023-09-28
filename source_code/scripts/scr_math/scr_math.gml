#macro INT_MAX 2147483647
function factorial(_n){
	var an = 1;
	for (var i=2;i<=_n;i++) an=an*i;
	return an;
}