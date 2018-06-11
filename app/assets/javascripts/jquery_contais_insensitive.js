/*
	Este Javascript adidionca no Jquery um comando para buscar elementos que contenham um 
	determinado texto de forma Insensitive (não diferenciando maiúsculas e minúsculass.)
	mais informações veja o bug do jquery em: http://bugs.jquery.com/ticket/278
*/
$.extend($.expr[':'], {

	'containsI': function(elem, i, match, array){
		return (elem.textContent || elem.innerText || '').toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
	},

	/*
		Assim como containsI, com attr_has(atributo,filtro) é possível pesquisar, não diferenciando maiúsculas e 
		minúsculas, elementos cujo *atributo* contém *filtro*
	*/
	'attr_has': function(elem, i, match, array){
		var params = match[3].split(',');
		return elem.getAttribute(params[0]).toLowerCase().indexOf((params[1] || "").toLowerCase()) >= 0 ;
	}

});