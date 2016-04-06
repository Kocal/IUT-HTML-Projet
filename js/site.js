$(document).ready(function(){
    
    $('body').append('<a href="html" class="top_link js-scrollTo" title="Revenir en haut de page">Top</a>');
    $('.top_link').css({
        'position'				:	'fixed',
        'right'					:	'2%',
        'bottom'				:	'50px',
        'display'				:	'none',
        'padding'				:	'20px',
        'background'			:	'#fff',
        'opacity'				:	'0.9',
        'z-index'				:	'2000',
        'text-decoration'       :   'none',
        'font-size'             :   '100%',
        'color'                 :   'black',
        'font-family'           :   'Orbitron, sans-serif',
    });
    
    $(window).scroll(function(){
        posScroll = $(document).scrollTop();
        if(posScroll >=screen.height) 
            $('.top_link').fadeIn(600);
        else
            $('.top_link').fadeOut(600);
    });
    
    $('.js-scrollTo').on('click', function() { // Au clic sur un élément
			var page = $(this).attr('href'); // Page cible
			var speed = 750; // Durée de l'animation (en ms)
			$('html, body').animate( { scrollTop: $(page).offset().top }, speed ); // Go
			return false;
    });
})