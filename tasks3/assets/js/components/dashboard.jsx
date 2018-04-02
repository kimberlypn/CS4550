import React from 'react';
import Task from './task';

export default function Dashboard(params) {
  let tasks = _.map(params.tasks, (t) => <Task key={pp.id} task={t} />);
  return <div>
    { tasks }
  </div>;
}
