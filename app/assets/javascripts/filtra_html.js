var FiltraHTML = {
	filtra: function(pesquisa, procurar){
		var filtro = pesquisa.val().trim();
		var condicao = filtro ? procurar.trim() + ':containsI("'+ filtro +'")' : procurar.trim();
		$(procurar).hide();
		$(condicao).show();
	}
}