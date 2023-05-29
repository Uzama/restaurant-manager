import React, {useContext} from 'react';
import './Login.css';
import { Link, useHistory } from 'react-router-dom';
import { useState } from "react";

import LoadingSpinner from "./Loading";
import AuthContext from "./authContext";

import axios from "axios";


function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const history = useHistory();

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const {apiKey, endpoint, setAuthKey, setUsername} = useContext(AuthContext);

  const handleEmailChange = (event) => {
    setEmail(event.target.value);
  };

  const handlePasswordChange = (event) => {
    setPassword(event.target.value);
  };

  const handleSubmit = (event) => {
    event.preventDefault();

    console.log(apiKey)
    console.log(endpoint)

    setLoading(true);

    const headers = {
        "content-type": "application/json",
        "x-api-key": apiKey
    };
    const graphqlQuery = {
        "operationName": "login",
        "query": `mutation login($email: String!, $password: String!) {
            login(input: {email: $email, password: $password}) {
              accessToken
              username
            }
          }
          `,
        "variables": {
            email: email,
            password: password,
        }
    };
    
    axios({
      url: endpoint,
      method: 'post',
      headers: headers,
      data: graphqlQuery
    }).then(response => {
        console.log(response.data.errors)
        if (response.data.errors) {
            setError(response.data.errors[0].message)
        } else {

            localStorage.setItem("token", response.data.data.login.accessToken);
            localStorage.setItem("name", response.data.data.login.username);

            setAuthKey(response.data.data.login.accessToken)
            setUsername(response.data.data.login.username)

            history.push("/account");
        }

    }) .catch(error => {
        console.log(error)
        // setError(error)
      })
      .finally(() => {
        setLoading(false); // Set loading to false after the request is complete (success or error)
      });
  };

  return (
    <div className="Login" container spacing={5}>
        {loading ? (
            <LoadingSpinner/>
        ) : (
        <div className="login-form-box">
            <h1>Restaurant Manager</h1>

            {/* {error ? <p className='error'>{error}</p> : null} */}
            
            <form onSubmit={handleSubmit} className='form'>
           
                <label htmlFor="email">Email</label><br />
                <input
                    type='email'
                    id='email'
                    aria-describedby='emailHelp'
                    placeholder='Enter email'
                    className='textfield'
                    value={email}
                    onChange={handleEmailChange}
                /> <br/>
            
                <label htmlFor="password">Password</label><br />
                <input
                    type='password'
                    id='password'
                    placeholder='Password'
                    className='textfield'
                    value={password}
                    onChange={handlePasswordChange}
                />
                <button
                    type='submit'
                    variant="contained" 
                    size="medium" 
                    className='Login-btn'
                >
                    Login
                </button>
            </form>

        <div className='newMerchantbox'>
            <Link to='/signup' id='create-acc'>
                Create Account
            </Link>
        </div>
    
        </div>
        )}
    </div>
  );
}

export default Login;
