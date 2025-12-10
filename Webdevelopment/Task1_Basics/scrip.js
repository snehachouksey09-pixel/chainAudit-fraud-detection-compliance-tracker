// -------------------------
// CONTACT FORM VALIDATION
// -------------------------
const form = document.getElementById("contactForm");
const formMsg = document.getElementById("formMsg");

form.addEventListener("submit", function(e){
    e.preventDefault(); // page reload roko

    // Input values
    const name = document.getElementById("name").value.trim();
    const email = document.getElementById("email").value.trim();
    const message = document.getElementById("message").value.trim();

    // Validation
    if(name === "" || email === "" || message === ""){
        formMsg.style.color = "red";
        formMsg.textContent = "Please fill all fields!";
    } else if(!validateEmail(email)){
        formMsg.style.color = "red";
        formMsg.textContent = "Please enter a valid email!";
    } else{
        formMsg.style.color = "green";
        formMsg.textContent = "Form submitted successfully!";
        form.reset();
    }
});

// Email validation function
function validateEmail(email){
    const re = /\S+@\S+\.\S+/;
    return re.test(email);
}

// -------------------------
// TO-DO LIST FUNCTIONALITY
// -------------------------
const taskInput = document.getElementById("taskInput");
const addTaskBtn = document.getElementById("addTaskBtn");
const taskList = document.getElementById("taskList");

// Add Task
addTaskBtn.addEventListener("click", function(){
    const task = taskInput.value.trim();
    if(task === "") return; // empty task ignore

    // Create list item
    const li = document.createElement("li");
    li.textContent = task;

    // Click to remove task
    li.addEventListener("click", function(){
        li.remove();
    });

    // Add to list
    taskList.appendChild(li);
    taskInput.value = ""; // clear input
});
