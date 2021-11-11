provider "aws" {
  region = "eu-west-1"
}
module "mfa" {
  source      = "../"
  name        = "mfa"
  environment = "test"
  Policy      = data.aws_iam_policy_document.enable_mfa.json
  users       = []
  groups      = []
}

data "aws_iam_policy_document" "enable_mfa" {

  statement {
    sid    = "AllowViewAccountInfo"
    effect = "Allow"
    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:ListVirtualMFADevices",
      "iam:ListMFADevices"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowManageOwnPasswords"
    effect = "Allow"
    actions = [
      "iam:ChangePassword",
      "iam:GetUser",
      "iam:CreateLoginProfile",
      "iam:DeleteLoginProfile",
      "iam:GetLoginProfile",
      "iam:UpdateLoginProfile"
    ]
    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  statement {
    sid    = "AllowManageOwnAccessKeys"
    effect = "Allow"
    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey"

    ]
    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]

  }

  statement {
    sid    = "AllowManageOwnSigningCertificates"
    effect = "Allow"
    actions = [
      "iam:DeleteSigningCertificate",
      "iam:ListSigningCertificates",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
    ]
    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  statement {
    sid    = "AllowManageOwnSSHPublicKeys"
    effect = "Allow"
    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey"

    ]
    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  statement {
    sid    = "AllowManageOwnGitCredentials"
    effect = "Allow"
    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:ResetServiceSpecificCredential",
      "iam:UpdateServiceSpecificCredential"
    ]
    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  statement {
    sid    = "AllowManageOwnVirtualMFADevice"
    effect = "Allow"
    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice"

    ]
    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]

  }

  statement {
    sid    = "AllowManageOwnUserMFA"
    effect = "Allow"
    actions = [
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice"

    ]
    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  statement {
    sid    = "DenyAllExceptListedIfNoMFA"
    effect = "Deny"
    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
      "iam:CreateLoginProfile",
      "iam:UpdateLoginProfile",
      "sts:GetSessionToken",
      "iam:ChangePassword"
    ]

    resources = ["*"]
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["false"]
    }
    condition {
      test     = "Bool"
      variable = "aws:ViaAWSService"
      values   = ["false"]
    }
  }


}