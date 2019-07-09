document.addEventListener('DOMContentLoaded', function(){

  const completeAlert  = document.querySelector('#completeAlert');
  const timeInput   = document.querySelector('#timeInput');
  const completeButton = document.querySelector('#completeButton');
  timeInput.value = "00:00";

  const balance     = document.querySelector('#balance');
  const fundsInput  = document.querySelector('#fundsInput');
  const fundsButton = document.querySelector('#fundsButton'); 
  const resetButton = document.querySelector('#resetButton');

  const useRewardButton = document.querySelectorAll('.useRewardButton');

  completeButton.addEventListener('click', () => {
    completeStudy();
  });

  fundsButton.addEventListener('click', () => {
    addFunds();
  });

  resetButton.addEventListener('click', () => {
    resetBalance();
  });

  document.addEventListener('click', () => {
    if(event.target.matches('.useRewardButton')){
      useReward();
    }
  });
});

function useReward(){
  console.log('Using reward...');
}

function getTime(){
  let time = timeInput.value;
  let timeParts = time.split(':');
  return {
    hours : parseInt(timeParts[0], 10),
    minutes : parseInt(timeParts[1], 10),
  }
}

function getBalance(){
  let funds = fundsInput.value;
  return funds;
}

function resetBalance(){
    fetch('/user/resetBalance', {
        headers: { "Content-Type": "application/json; charset=utf-8" },
        method: 'POST', 
       })
      .then(res => res.json())
      .then(response => {
        balance.innerHTML = response.balance 
      });
}

function addFunds(){
    let funds = getBalance();
    fetch('/user/addFunds', {
        headers: { "Content-Type": "application/json; charset=utf-8" },
        method: 'POST', 
        body: JSON.stringify({funds: funds})
       })
      .then(res => res.json())
      .then(response => {
        balance.innerHTML = response.balance 
      });
}

function completeStudy(){
    let seconds = getSeconds(); 
    
    if(parseInt(seconds, 10) <= 0){
      showFailAlert();  
      return;
    }
    fetch('/study/create', {
        headers: { "Content-Type": "application/json; charset=utf-8" },
        method: 'POST', 
        body: JSON.stringify({time: seconds})
       })
      .then(res => res.json())
      .then(response => {
        console.log(response);
        showCompleteAlert();
      });

}

function showFailAlert(){
    failAlert.classList.remove('d-none');
    setTimeout(() => {
      failAlert.classList.add('d-none');
    }, 5000);
}

function showCompleteAlert(){
    let time = getTime(); 
    let hourText = (time.hours == 1) ? 'hour' : 'hours';
    let minuteText = (time.minutes == 1) ? 'minute' : 'minutes';

    //completeButton.setAttribute('disabled', 'disabled');
    //completeAlert.innerHTML = `Good job! Your study session of ${time.hours} ${hourText} and ${time.minutes} ${minuteText} has been recorded.`;
    //completeAlert.classList.remove('d-none');

    window.location.reload();
    // setTimeout(() => {
    //   completeAlert.classList.add('d-none');
    //   completeButton.removeAttribute('disabled');
    // }, 5000);
}

function getTime(){
  let time = timeInput.value;
  let timeParts = time.split(':');
  return {
    hours : parseInt(timeParts[0], 10),
    minutes : parseInt(timeParts[1], 10),
  }
}

function getSeconds(){
  let time = timeInput.value;
  let timeParts = time.split(':');

  let hours = (parseInt(timeParts[0],10)*60)*60;
  if(isNaN(hours)){
    hours = 0;
  }

  let minutes = parseInt(timeParts[1],10)*60;
  if(isNaN(minutes)){
    minutes = 0;
  }

  return hours + minutes;
}
