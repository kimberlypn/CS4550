import React from 'react';
import { Button, FormGroup, Label, Input } from 'reactstrap';

export default function TaskForm(params) {
  let users = _.map(params.users, (u) => <option key={u.id}
  value={u.id}>{u.name}</option>);

  return <div style={{padding: "4ex"}}>
    <h2>New Task</h2>
    <FormGroup>
      <Label for="user_id">User</Label>
      <Input type="select" name="user_id">
        { users }
      </Input>
    </FormGroup>
    <FormGroup>
      <Label for="body">Body</Label>
      <Input type="textarea" name="body" />
    </FormGroup>
    <Button onClick={() => alert("TODO: Manage State")}>Task</Button>
  </div>;
}
