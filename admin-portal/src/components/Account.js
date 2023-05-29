import React, {useContext, useEffect, useState} from 'react';
import './Account.css';
import { Link, useHistory } from 'react-router-dom';

import LoadingSpinner from "./Loading";
import AuthContext from "./authContext";
import AdminNavBar from "./AdminNavBar";

import axios from "axios";

function Account() {
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState("");

    const history = useHistory();

    const {authKey, setAuthKey, endpoint, username, setUsername} = useContext(AuthContext);

    if (!authKey) {
        setAuthKey(localStorage.getItem("token"))
    }

    if (!username) {
        setUsername(localStorage.getItem("name"))
    }

    const [data, setData] = useState([]);

    useEffect(() => {
        setLoading(true);

        const headers = {
            "content-type": "application/json",
            "Authorization": authKey
        };
        const graphqlQuery = {
            "operationName": "getRestaurant",
            "query": `query getRestaurant($id: String!) {
                getRestaurant(id: $id) {
                  address
                  name
                  phone
                  username
                }
              }
            `,
            "variables": {
                id: username
            }
        };
        
        axios({
        url: endpoint,
        method: 'post',
        headers: headers,
        data: graphqlQuery
        }).then(response => {
            if (response.data.errors) {
                console.log(response.data.errors)
                setError(response.data.errors[0].message)
            } else {

                setData(response.data.data.getRestaurant)
            }

        }) .catch(error => {
            if (error.message == "Request failed with status code 401") {
                history.push("/");
            }
            setError(error.message)
        })
        .finally(() => {
            setLoading(false); // Set loading to false after the request is complete (success or error)
        });
    }, [authKey, endpoint, username]);

  return (
    <div>
        <AdminNavBar />
        <div className="Account" container spacing={5}>
        
        {loading ? (
            <LoadingSpinner/>
        ) : (
        <div className="details">

            {error ? <p className='error'>{error}</p> : 
            <div className='accountInformationContainer'>
                <div className='logo'></div>
                <p className='username'>@{data.username}</p>
                <p className='accountInformation'>Restaurant Name: {data.name}</p>
                <p className='accountInformation'>Phone: {data.phone}</p>
                <p className='accountInformation'>Address: {data.address}</p>
            </div>
            }
        </div>
        )}
    </div>
    </div>
  );
}

export default Account;