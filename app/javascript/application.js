// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import JSConfetti from 'js-confetti'



document.addEventListener("turbo:before-stream-render", function() {
  console.log("Actualizando")
  const confeti = document.querySelector("#confeti")

  if(confeti){
    const jsConfetti = new JSConfetti()
    jsConfetti.addConfetti({
      emojiSize: 50,
      confettiNumber: 500,
    })
  }  
});
















