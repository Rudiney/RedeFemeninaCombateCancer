var EscondeInformacao = {
	
	click: function(elemento, seletor){
		if($(elemento).hasClass('recolhido')){
			this.expande($(elemento),seletor);
		}else{
			this.recolhe($(elemento),seletor);
		}
	},
	
	expande: function(elemento, seletor){
		elemento.removeClass('recolhido').addClass('expandido');
		$(seletor).show();
	},
	
	recolhe: function(elemento, seletor){
		elemento.removeClass('expandido').addClass('recolhido');
		$(seletor).hide();
	}
};