import React, {useState, useEffect} from 'react';
import { BrowserRouter, Switch, Route } from 'react-router-dom'; 

import AuthContext from "./authContext"

import Login from "./Login"
import Signup from "./Signup"
import Account from "./Account"
import AuthRoute from "./AuthRoute"
import NotFoundPage from "./NotFoundPage"
import Orders from "./Orders"
import MenueItems from "./MenueItems"

import AWS from 'aws-sdk';

AWS.config.update({
  accessKeyId: process.env.REACT_APP_AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.REACT_APP_AWS_SECRET_ACCESS_KEY,
  region: 'us-east-1',
});

const APIKEY = "/restaurant-manager/appsync/graphql/cognito/apikey"
const ENDPOINT = "/restaurant-manager/appsync/graphql/cognito/endpoint"

function App() {

    const [authKey, setAuthKey] = useState(localStorage.getItem("token"));
    const [username, setUsername] = useState(localStorage.getItem("name"));
    const endpoint = localStorage.getItem(ENDPOINT)
    const apiKey = localStorage.getItem(APIKEY)

    useEffect(() => {
        const ssm = new AWS.SSM();

        ssm.getParameters({
          Names: [APIKEY, ENDPOINT],
          WithDecryption: true, // Set to true if the parameter value is encrypted
        }).promise()
        .then(response => {
            localStorage.setItem(APIKEY, response.Parameters[0].Value)
            localStorage.setItem(ENDPOINT, response.Parameters[1].Value)
        }) .catch(error => {
          console.log(error)
      }) 
    }, []);

    var isAuthenticated = localStorage.getItem("token") != null

    console.log(apiKey)
    console.log(endpoint)

    return (
      <AuthContext.Provider value={{authKey, setAuthKey, endpoint, apiKey, username, setUsername}}>
      <div className='App'>
        <BrowserRouter>
          {/* <Header /> */}
          <Switch>
  
            <Route exact path='/'>
              <Login />
            </Route>

            <Route exact path='/signup'>
              <Signup />
            </Route>

            <AuthRoute
              path="/account"
              component={Account}
              isAuthenticated={isAuthenticated}
            />
            <AuthRoute
              path="/orders"
              component={Orders}
              isAuthenticated={isAuthenticated}
            />
            <AuthRoute
              path="/menue"
              component={MenueItems}
              isAuthenticated={isAuthenticated}
            />

            <Route component={NotFoundPage} />

            </Switch>
            </BrowserRouter>
            </div>
      </AuthContext.Provider>
    )
}

export default App;