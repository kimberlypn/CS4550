// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

/*
  Functions were taken and adapted from Nat's lecture notes
*/

var START_TIME = "";
var TIME_ID = "";

// Toggle the button text
function update_buttons() {
  $('.manage-button').each( (_, bb) => {
    let user_id = $(bb).data('user-id');
    let manage = $(bb).data('manage');
    if (manage != "") {
      $(bb).text("Unmanage");
    }
    else {
      $(bb).text("Manage");
    }
  });
}

// Update the data so that the text is toggled properly
function set_button(user_id, value) {
  $('.manage-button').each( (_, bb) => {
    if (user_id == $(bb).data('user-id')) {
      $(bb).data('manage', value);
    }
  });
  update_buttons();
}

// Create a Manage record
function manage(user_id) {
  let text = JSON.stringify({
    manage: {
      manager_id: current_user_id,
      underling_id: user_id
    },
  });

  $.ajax(manage_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(user_id, resp.data.id); },
    error: (resp) => { console.log(resp); }
  });
}

// Delete a Manage record
function unmanage(user_id, manage_id) {
  $.ajax(manage_path + "/" + manage_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => { set_button(user_id, ""); },
  });
}

// Manage or unmanage a user corresponding the the button clicked
function manage_click(ev) {
  let btn = $(ev.target);
  let manage_id = btn.data('manage');
  let user_id = btn.data('user-id');

  if (manage_id != "") {
    unmanage(user_id, manage_id);
  }
  else {
    manage(user_id);
  }
}

// Initialize the click function for each manage button
// and update the button text
function init_manage() {
  if (!$('.manage-button')) {
    return;
  }
  $(".manage-button").click(manage_click);
  update_buttons();
}

// Toggle the link text
function end_links() {
  $('.time-button').each( (_, bb) => {
    let task_id = $(bb).data('task-id');
    let type = $(bb).data('type');
    let clicked = $(bb).data('clicked');
    // Change the 'Start' link to a text-like 'In Progress'
    if (type === "Start" && clicked === "Yes") {
      $(bb).text('In Progress');
      $(bb).click(function() { return false; });
      $(bb).css('color', '#7c91af');
      $(bb).css('cursor', 'default');
    }
    // Change the 'In Progress' message back to a 'Start' link
    else if (type === "Start" && clicked === "No") {
      $(bb).text('Start');
      $(bb).css('color', '#007bff');
      $(bb).css('cursor', 'pointer');
    }
    else if (type === "End") {
      $(bb).text('End');
    }
    else if (type === "Edit") {
      // Submit button for the edit form
      $(bb).text('Submit');
    }
    else {
      $(bb).text('Delete');
    }
  });
}

// Update the data so that the text is toggled properly
function set_time_link(task_id, type) {
  $('.time-button').each( (_, bb) => {
    if (type === "Start") {
      if (task_id == $(bb).data('task-id') && $(bb).data('type') === "Start") {
        $(bb).data('clicked', "Yes");
      }
    }
    else {
      // Change the clicked flag of the Start button back to "No" so that it
      // will render as a 'Start' link again
      if (task_id == $(bb).data('task-id') && $(bb).data('type') === "Start") {
        $(bb).data('clicked', "No");
        // Cleat the time id so that the user cannot click 'End' before
        // clicking 'Start'
        TIME_ID = "";
      }
    }
  });
  end_links();
}

// Create a TimeBlock record
function start(task_id, time, btn) {
  let text = JSON.stringify({
    time_block: {
      start: time,
      end: null,
      task_id: task_id,
      convert: true
    },
  });

  $.ajax(time_block_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => {
      TIME_ID = resp.data.id;
      set_time_link(task_id, "Start"); },
    error: (resp) => { console.log(resp); }
  });
}

// Update a time block
function end(task_id, time) {
  if (TIME_ID == "") {
    alert("You haven't started the task yet.");
  }

  else {
    let text = JSON.stringify({
      time_block: {
        start: START_TIME,
        end: time,
        convert: true
      },
    });

    $.ajax(time_block_path + "/" + TIME_ID, {
      method: "put",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => { set_time_link(task_id, "End"); },
      error: (resp) => { console.log(resp); }
    });
  }
}

function edit_time() {
  alert("hi");
}

function delete_time(time_id) {
  $.ajax(time_block_path + "/" + time_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => { set_button(task_id, "Delete"); },
  });
  location.reload();
}

function time_click(ev) {
  let btn = $(ev.target);
  let type = btn.data('type');
  let task_id = btn.data('task-id');
  let time = btn.data('time');
  if (type === "Start") {
    START_TIME = time;
    start(task_id, time, btn);
  }
  else if (type == "End") {
    end(task_id, time);
  }
  else if (type == "Edit") {
    edit_time();
  }
  else {
    delete_time(btn.data('time-id'), task_id);
  }
}

function init_time() {
  if (!$('.time-button')) {
    return;
  }
  $(".time-button").click(time_click);
  end_links();
}

$(init_manage);
$(init_time);
