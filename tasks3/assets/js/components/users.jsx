import React from 'react';
import { Link } from 'react-router-dom';

function User(params) {
  return <p>{params.user.name} -
    <Link to={"/users/" + params.user.id}>tasks</Link></p>;
}

export default function Users(params) {
  let users = _.map(params.users, (u) => <User key={u.id} user={u} />);
  return <div>
    { users }
  </div>;
}
