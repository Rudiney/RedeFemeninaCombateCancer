var Crud = {
	
	exibeResumo: function(id_ou_linha){
		if(id_ou_linha.id)   { Crud.exibeResumoDoId(id_ou_linha.id); return; }
		if(id_ou_linha.linha){ Crud.exibeResumoDaLinha(id_ou_linha.linha); return; }
	},
	
	exibeResumoDoId: function(id){
		Crud.exibeResumoDaLinha($('#crud_index #indice .item[id='+id+']'));
	},
	
	exibeResumoDaLinha: function(linha){
		var id = linha.attr('id');
		$('#crud_index .resumos .resumo').hide().filter('[registro="'+id+'"]').show();
		$('#crud_index #indice .item').removeClass('selecionado').removeClass('depois_do_selecionado');
		linha.addClass('selecionado').next().addClass('depois_do_selecionado');
	}
};

$(function(){
	$('#crud_index #indice .item').bind('click', function(){
		Crud.exibeResumoDaLinha($(this));
	})
})