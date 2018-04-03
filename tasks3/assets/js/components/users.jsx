import React from 'react';
import { Link } from 'react-router-dom';

// Adapted from Nat's lecture notes
function User(props) {
  return <p>{props.user.name} -
    <Link to={"/users/" + props.user.id}>tasks</Link></p>;
}

export default function Users(props) {
  let users = _.map(props.users, (u) => <User key={u.id} user={u} />);
  return <div>
    { users }
  </div>;
}
