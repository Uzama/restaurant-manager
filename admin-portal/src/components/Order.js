import React, { useState, useContext, useEffect } from "react";

import { FcExpand, FcCollapse } from "react-icons/fc";
import { AiFillDelete } from "react-icons/ai";
import { BiBookAdd } from "react-icons/bi";
import { MdAddCircleOutline } from "react-icons/md";

import "./Order.css"

import { useHistory } from 'react-router-dom';

import LoadingSpinner from "./Loading";
import AuthContext from "./authContext";

import axios from "axios";

function Order({data}) {
    const {authKey, setAuthKey, endpoint, username, setUsername} = useContext(AuthContext);

    if (!authKey) {
        setAuthKey(localStorage.getItem("token"))
    }

    if (!username) {
        setUsername(localStorage.getItem("name"))
    }

    const history = useHistory();

    const [trigger, setTrigger] = useState(false);

    const [isExpanded, setIsExpanded] = useState(false);
    const [addNewItem, setAddNewItem] = useState(false);

    const [listItem, setListItem] = useState([]);
    const [listMenueItem, setListMenueItem] = useState([]);

    const [loading, setLoading] = useState(false);
    const [error, setError] = useState("");

    const [selectedOption, setSelectedOption] = useState('');

    const handleOptionChange = (event) => {
        setSelectedOption(event.target.value);
    };

    const toggleExpand = () => {
        setIsExpanded(!isExpanded);
        setTrigger((prevTrigger) => !prevTrigger);
    };

    useEffect(() => {
        setLoading(true);

        const headers = {
            "content-type": "application/json",
            "Authorization": authKey
        };
        const graphqlQuery = {
            "operationName": "listOrderItems",
            "query": `query listOrderItems($orderId: String!) {
                listOrderItems(orderId: $orderId) {
                  id
                  menu_item_id
                  name
                  order_id
                  price
                  quantity
                }
              }
            `,
            "variables": {
                orderId: data.id
            }
        };
        
        axios({
        url: endpoint,
        method: 'post',
        headers: headers,
        data: graphqlQuery
        }).then(response => {
            console.log(response)
            if (response.data.errors) {
                setError(response.data.errors[0].message)
            } else {
                setListItem(response.data.data.listOrderItems)
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
    }, [authKey, endpoint, username, trigger]);

    const toggleAddItem = () => {

        setAddNewItem(!addNewItem);

        const headers = {
            "content-type": "application/json",
            "Authorization": authKey
        };
        const graphqlQuery = {
            "operationName": "getMenue",
            "query": `query getMenue($username: String!) {
                getMenue(restaurantUsername: $username) {
                  description
                  id
                  name
                  price
                }
              }
            `,
            "variables": {
                username: username
            }
        };
        
        axios({
        url: endpoint,
        method: 'post',
        headers: headers,
        data: graphqlQuery
        }).then(response => {
            console.log(response)
            if (response.data.errors) {
                setError(response.data.errors[0].message)
            } else {
                setListMenueItem(response.data.data.getMenue)
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
    };

    const handleSubmit = (event) => {
        event.preventDefault();
    
        setLoading(true);
    
        const headers = {
            "content-type": "application/json",
            "Authorization": authKey
        };
        const graphqlQuery = {
            "operationName": "addOrderItem",
            "query": `mutation addOrderItem($menueItemId: String!, $orderId: String!, $quantity: Int!) {
                addOrderItem(input: {menueItemId: $menueItemId, orderId: $orderId, quantity: $quantity}) {
                  id
                  menu_item_id
                  name
                  order_id
                  price
                  quantity
                }
              }`,
            "variables": {
                menueItemId: selectedOption,
                orderId: data.id,
                quantity: 1
            }
        };
        
        axios({
          url: endpoint,
          method: 'post',
          headers: headers,
          data: graphqlQuery
        }).then(response => {
            if (response.data.errors) {
                setError(response.data.errors[0].message)
            } else {
                setTrigger((prevTrigger) => !prevTrigger); 
            }
    
        }) .catch(error => {
            setError(error)
          })
          .finally(() => {
            setAddNewItem(!addNewItem);
            setLoading(false); // Set loading to false after the request is complete (success or error)
          });
      };

    return (
        <div className="orderItemContainer">
            <div className="orderContainer">
                <div className="orderDetailsContainer">
                    <div className="orderDetails">
                        <p>orderId: {data.id}</p>
                        <p>status: {data.order_status}</p>
                        <p>date: {data.order_date}</p>
                    </div>
                    <div className="customerDetails">
                        <p>customerName: {data.customer_name}</p>
                        <p>customerPhone: {data.customer_phone}</p>
                    </div>
                </div>
                <div className="deleteOrderContainer">
                    <AiFillDelete size="3em" className="deleteIcon"/>
                </div>
            </div>
            {isExpanded && (

                <div className="itemListContainer">
                    <div className="itemListHeader">
                        <h3 >Items List</h3>
                        <BiBookAdd className="BiBookAdd" size="2em" color="rgb(36, 124, 225)" onClick={toggleAddItem}/>
                    </div>
                    <div className="itemListBody">
                        {
                        loading ? 
                        <LoadingSpinner />
                        :
                           
                        addNewItem ? 
                        <>
                        {error ? <p>{error}</p> : null}
                        <form onSubmit={handleSubmit}  className='menueItemListForm'>
                            <select className="selectionField" value={selectedOption} required onChange={handleOptionChange}>
                                <option value="">Select an Item</option>
                                {
                                    listMenueItem.map(item => {
                                        return(<option key={item.id} value={item.id}>{item.name}</option>)
                                    })
                                }
                            </select> <br/>
                            <button
                                type='submit'
                            >
                                <MdAddCircleOutline />
                            </button>
                        </form>
                        </>
                        :
                        
                        listItem && listItem.length > 0 ? 
                        
                            listItem.map(liI => {
                                return (
                                    <div className="itemListBodyItem">
                                        <div className="itemListBodyDetails">
                                            <p>Name: {liI.name}</p>
                                            <p>Price: {liI.price}</p>
                                            <p>Quantity: {liI.quantity}</p>
                                        </div>
                                        <div className="itemListBodydelete">
                                            <AiFillDelete color="grey" size="2em"/>
                                        </div>
                                </div>
                                )
                            })
                        
                        : 
                        <p>empty</p>

                        }       
                    </div>
                </div>
            )}
            <div className="expandButton">
                <i onClick={toggleExpand}>{isExpanded ? <FcCollapse/> : <FcExpand/>}</i>
            </div>
            
        </div>
    );
  }
  
export default Order