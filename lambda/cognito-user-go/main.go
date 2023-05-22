package main

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"strings"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/cognitoidentityprovider"
	"github.com/aws/aws-sdk-go/service/cognitoidentityprovider/cognitoidentityprovideriface"
)

type CognitoManagement struct {
	cognitoClient cognitoidentityprovideriface.CognitoIdentityProviderAPI
}

func createSession() (*session.Session, error) {
	
	sess, err := session.NewSessionWithOptions(session.Options{
		Config: aws.Config{Region: aws.String(os.Getenv("AWS_REGION"))},
	})

	return sess, err
}

type Input struct {
	Action                string `json:"action"`
	Username 			  string `json:"username"`
	Email                 string `json:"email"`
	ClientId              string
	UserPoolId            string
	Password              string `json:"password"`
	Name           		  string `json:"name"`
	Address           	  string `json:"address"`
	Phone           	  string `json:"phone"`
}

type Response struct {
	Username 	string `json:"username"`
	Name        string `json:"name"`
	Address     string `json:"address"`
	Phone       string `json:"phone"`
}

func (c *CognitoManagement) decodeInput(evt json.RawMessage) (*Input, error) {
	
	params := &Input{}

	err := json.Unmarshal(evt, params)

	return params, err
}

func (c *CognitoManagement) SignUp(evt Input) (string, error) {
	
	userSignup := &cognitoidentityprovider.SignUpInput{
		ClientId: aws.String(evt.ClientId),
		Password: aws.String(evt.Password),
		Username: aws.String(evt.Email),
	}

	result, err := c.cognitoClient.SignUp(userSignup)

	return *result.UserSub, err
}

func (c *CognitoManagement) AdminDisableUser(evt Input) (error) {
	
	disableUserData := &cognitoidentityprovider.AdminDisableUserInput{
		UserPoolId: aws.String(evt.UserPoolId),
		Username:   aws.String(evt.Email),
	}

	_, err := c.cognitoClient.AdminDisableUser(disableUserData)
	
	return err
}

func (c *CognitoManagement) AdminDeleteUser(evt Input) (error) {
	
	d := &cognitoidentityprovider.AdminDeleteUserInput{
		UserPoolId: aws.String(evt.UserPoolId),
		Username:   aws.String(evt.Email),
	}

	_, err := c.cognitoClient.AdminDeleteUser(d)
	if err != nil {
		return err
	}

	return nil
}

func (c *CognitoManagement) Action(evt Input) (*Response, error) {
	
	response := &Response{
		Name: evt.Name,
		Address: evt.Address,
		Phone: evt.Phone,
	}

	if evt.Email == "" {
		return nil, errors.New("you must supply an user email address")
	}

	if !strings.Contains(evt.Email, "@") {
		return nil, errors.New("incorrect Email")
	}
	
	getUserData := &cognitoidentityprovider.AdminGetUserInput{
		UserPoolId: aws.String(evt.UserPoolId),
		Username:   aws.String(evt.Email),
	}

	switch evt.Action {
	
	case "CREATE":
		
		if evt.Password == "" {
			return nil, errors.New("you must supply password")
		}

		_, err := c.cognitoClient.AdminGetUser(getUserData)

		if err != nil {
			if strings.Contains(err.Error(), cognitoidentityprovider.ErrCodeUserNotFoundException) {
				
				response.Username, err = c.SignUp(evt)
				if err == nil {
					
					usr, err := c.cognitoClient.AdminGetUser(getUserData)
					if err == nil {
						response.Username = *usr.Username
					}
					
					return response, err
				}
				
				return response, err
			}
		} 
		
		if err == nil {
			return nil, errors.New("this user exists, can't be created")
		}
		

	case "DELETE_USER":

		if evt.Username == "" {
			return nil, errors.New("you must supply username")
		}
		
		err := c.AdminDisableUser(evt)
		if err != nil {
			return nil, err
		}
		
		err = c.AdminDeleteUser(evt)
		if err != nil {
			return nil, err
		}

		response.Username = evt.Username
		
		return response, err
	}
	
	return response, nil
}

func (c *CognitoManagement) handler(ctx context.Context, evt json.RawMessage) (json.RawMessage, error) {
	
	if c.cognitoClient == nil {
		sess, _ := createSession()
		c.cognitoClient = cognitoidentityprovider.New(sess)
	}

	params, err := c.decodeInput(evt)
	if err != nil {
		fmt.Println("Error decoding input")
		return nil, err
	}

	params.ClientId = os.Getenv("COGNITO_CLIENT_ID")
	params.UserPoolId = os.Getenv("COGNITO_USER_POOL")

	response, err := c.Action(*params)
	if err != nil {
		return nil, err
	}

	ret, _ := json.Marshal(response)
	return ret, nil
}

func main() {
	s := CognitoManagement{
		cognitoClient: nil,
	}

	lambda.Start(s.handler)
}
