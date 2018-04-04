import store from './store';

class TheServer {
  request_tasks() {
    $.ajax("/api/v1/tasks", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        store.dispatch({
          type: 'TASKS_LIST',
          tasks: resp.data,
        });
      },
    });
  }

  request_users() {
    $.ajax("/api/v1/users", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        store.dispatch({
          type: 'USERS_LIST',
          users: resp.data,
        });
      },
    });
  }

  submit_task(data) {
    $.ajax("/api/v1/tasks", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({token: data.token, task: data}),
      success: (resp) => {
        alert("Successfully created the task!");
        store.dispatch({
          type: 'ADD_TASK',
          task: resp.data,
        });
      },
      error: (resp) => {
        alert("Could not create the task. Please try again.");
      }
    });
  }

  submit_login(data) {
    $.ajax("/api/v1/token", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify(data),
      success: (resp) => {
        store.dispatch({
          type: 'SET_TOKEN',
          token: resp,
        });
      },
      error: (resp) => {
        alert("Could not log in. Please try again.");
      }
    });
  }

  delete_task(data) {
    $.ajax("/api/v1/tasks/" + data, {
      method: "delete",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify(data),
      success: (resp) => {
        store.dispatch({
          type: 'TASKS_LIST',
          tasks: resp.data,
        });
      },
      error: (resp) => {
        alert("Could not delete the task. Please try again.");
      }
    });
  }

  edit_task(data) {
    $.ajax("/api/v1/tasks/" + data.id, {
      method: "patch",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({token: data.token, task: data}),
      success: (resp) => {
        store.dispatch({
          type: 'TASKS_LIST',
          tasks: resp.data,
        });
      },
      error: (resp) => {
        alert("Could not edit the task. Please try again.");
      }
    });
  }

  create_user(data) {
    $.ajax("/api/v1/users", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({user: data}),
      success: (resp) => {
        alert("Successfully registered! You can now log in.");
        store.dispatch({
          type: 'ADD_USER',
          user: resp.data,
        });
      },
      error: (resp) => {
        alert("Failed to register. Please try again.");
      },
    });
  }
}

export default new TheServer();
