import React, { useContext } from 'react';
import './Signup.css';
import { Link, useHistory } from 'react-router-dom';
import { useState } from "react";

import LoadingSpinner from "./Loading";
import AuthContext from "./authContext";

import axios from "axios";

function Signup() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [name, setName] = useState("");
  const [address, setAddress] = useState("");
  const [phone, setPhone] = useState("");
  const history = useHistory();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const {apiKey, endpoint} = useContext(AuthContext);

  const handleEmailChange = (event) => {
    setEmail(event.target.value);
  };

  const handlePasswordChange = (event) => {
    setPassword(event.target.value);
  };

  const handleNameChange = (event) => {
    setName(event.target.value);
  };

  const handleAddressChange = (event) => {
    setAddress(event.target.value);
  };

  const handlePhoneChange = (event) => {
    setPhone(event.target.value);
  };

  const handleSubmit = (event) => {
    event.preventDefault();

    setLoading(true);

    const headers = {
        "content-type": "application/json",
        "x-api-key": apiKey
    };
    const graphqlQuery = {
        "operationName": "createRestaurant",
        "query": `mutation createRestaurant($address: String, $email: String!, $name: String!, $password: String!, $phone: String) {
            createRestaurant(input: {address: $address, email: $email, name: $name, password: $password, phone: $phone}) {
              username
              phone
              name
              address
            }
          }`,
        "variables": {
            address: address,
            email: email,
            name: name,
            password: password,
            phone: phone
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
            history.push("/");
        }

    }) .catch(error => {
        setError(error)
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

            {error ? <p className='error'>{error}</p> : null}
            
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
                <label htmlFor="name">Restaurant Name</label><br />
                <input
                    type='text'
                    id='name'
                    placeholder='Enter Restaurant Name'
                    className='textfield'
                    value={name}
                    onChange={handleNameChange}
                /> <br/>
                <label htmlFor="address">Address</label><br />
                <input
                    type='text'
                    id='address'
                    placeholder='Enter Address'
                    className='textfield'
                    value={address}
                    onChange={handleAddressChange}
                /> <br/>
                <label htmlFor="phone">Phone</label><br />
                <input
                    type='text'
                    id='phone'
                    placeholder='Enter Phone'
                    className='textfield'
                    value={phone}
                    onChange={handlePhoneChange}
                /> <br/>
                <button
                    type='submit'
                    variant="contained" 
                    size="medium" 
                    className='Login-btn'
                >
                    Create Account
                </button>
            </form>

        <div className='newMerchantbox'>
            <Link to='/' id='create-acc'>
                Login
            </Link>
        </div>
    
        </div>
        )}
    </div>
  );
}

export default Signup;
