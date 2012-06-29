/*!
Deck JS - deck.notes - v1.0
Copyright (c) 2011 Esa-Matti Suuronen
Dual licensed under the MIT license and GPL license.
https://github.com/imakewebthings/deck.js/blob/master/MIT-license.txt
https://github.com/imakewebthings/deck.js/blob/master/GPL-license.txt
*/

/*
This module adds the methods and key binding to show and hide a menu of all
slides in the deck. The deck menu state is indicated by the presence of a class
on the deck container.
*/
(function($, deck, undefined) {
  var $d = $(document);


  function displayNotes(slideId) {
    var noteContainer = $(".deck-note-container");
    var notes = $(".deck-notes,.deck-show-notes");

    var note = $[deck]('getSlide', slideId).find(".note");
    console.log("note is ", note.html());

    if (note.size() > 0) {
      noteContainer.html(note.html());
      notes.removeClass("deck-hide-always");
    }
    else {
      notes.addClass("deck-hide-always");
    }
  }

  $d.bind('deck.init', function() {
    var noteWrapper = $(".deck-notes");
    var showNotesButton = $(".deck-show-notes");

    $("a.deck-hide-notes").click(function() {
      noteWrapper.hide();
      showNotesButton.removeClass("deck-hide-button");
    });

    $(".deck-show-notes a").click(function() {
      showNotesButton.addClass("deck-hide-button");
      noteWrapper.show();
    });

    if (!window.location.hash) {
      displayNotes(0);
    }

  });

  $d.bind('deck.change', function(e, from, to) {
    displayNotes(to);
  });

})(jQuery, 'deck');

