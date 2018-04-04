// Adapted from Nat's lecture notes
import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze';

function tasks(state = [], action) {
  switch (action.type) {
  case 'TASKS_LIST':
    return [...action.tasks];
  case 'ADD_TASK':
    return [action.task, ...state];
  default:
    return state;
  }
}

function users(state = [], action) {
  switch (action.type) {
  case 'USERS_LIST':
    return [...action.users];
  default:
    return state;
  }
}

let empty_form = {
  user_id: "",
  title: "",
  description: "",
  time_spent: 0,
  completed: false,
  token: "",
  id: "",
  session_id: ""
};

function form(state = empty_form, action) {
  switch (action.type) {
    case 'UPDATE_FORM':
      return Object.assign({}, state, action.data);
    case 'CLEAR_FORM':
      let cleared = {
        title: "",
        description: "",
        time_spent: 0,
        completed: false
      }
      return Object.assign({}, state, cleared);
    case 'SET_TOKEN':
      let session = {
        session_id: action.token.user_id,
        token: action.token.token,
        user_id: action.token.user_id
      }
      return Object.assign({}, state, session);
    default:
      return state;
  }
}

function token(state = null, action) {
  switch (action.type) {
    case 'SET_TOKEN':
      return action.token;
    default:
      return state;
  }
}

let empty_login = {
  email: "",
  pass: "",
};

function login(state = empty_login, action) {
  switch (action.type) {
    case 'UPDATE_LOGIN_FORM':
      return Object.assign({}, state, action.data);
    default:
      return state;
  }
}

function root_reducer(state0, action) {
  console.log("reducer", action);
  // {tasks, users, form} is ES6 shorthand for
  // {tasks: tasks, users: users, form: form}
  let reducer = combineReducers({tasks, users, form, token, login});
  let state1 = reducer(state0, action);
  return deepFreeze(state1);
};

let store = createStore(root_reducer);
export default store;
